defmodule Mix.Tasks.Codegen do
  @moduledoc """

  Runs Codegen based on input file.

  This task does nothing on its own and requires another package
  to implement the generation of code based on a template file.

  Look at the `mix_codegen_ecto_migration` package for an example.

  By default, a config file will be sourced from the
  following locations, in order:

    * $MIX_PROJECT_ROOT/config/codegen.json
    * $MIX_PROJECT_ROOT/codegen.json

  ## Examples

    mix codegen help
    mix codegen run
    mix codegen run -f priv/gen/codegen.json
    mix codegen run --input-file priv/gen/codegen.json
  """

  use Mix.Task
  alias MixCodegen, as: Codegen

  @shortdoc "Run code generation tasks based upon input file"

  @aliases [
    h: :help,
    f: :input_file
  ]

  @switches [
    help: :boolean,
    input_file: :string,
    no_compile: :boolean,
    no_deps_check: :boolean
  ]

  @doc "Run the Mix.Codegen Task, parsing arguments and delegating to other methods to execute"
  @spec run(map) :: none()
  def run(args) do
    IO.puts("Passed Args: #{args}")

    OptionParser.parse(args, strict: @switches, aliases: @aliases)
    |> IO.inspect(label: "Parsed Args")
    |> parse_command()
    |> run_command()

    exit(:normal)
  end

  @doc "Parse the incoming parameters to Mix.Codegen"
  @spec parse_command({any(), any(), any()}) :: :help | :run
  def parse_command({[], ["run"], _}), do: {:run, :default}
  def parse_command({[input_file: file], ["run"], _}), do: {:run, file}
  def parse_command({_, _, _}), do: :help

  @doc "Execute either the :help or :run commands of Mix.Codegen"
  @spec run_command(:help) :: any()
  def run_command(:help), do: print_usage()

  @spec run_command({:run, String.t()}) :: any()
  def run_command({:run, file}) do
    try do
      IO.puts("Run file #{file}")
      Codegen.codegen_from_file(file)
    rescue
      e in CodegenConfigNotFound -> Mix.shell().error(e.message)
      e in CodegenConfigParseError -> Mix.shell().error(e.message)
    end
  end

  defp print_usage() do
    Mix.Task.get("codegen")
    |> Mix.Task.moduledoc()
    |> IO.puts()
  end
end
