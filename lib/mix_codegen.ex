defmodule MixCodegen do
  @moduledoc """
  Documentation for MixCodegen.
  """

  alias MixCodegen.Config, as: CodeConfig
  require IEx

  @doc """
  Execute MixCodegen based on either a file passed as input, or the :default
  codegen where a default config file is used
  """
  @spec codegen_from_file(:default | String.t()) :: :ok
  def codegen_from_file(file \\ :default) do
    IO.puts("MixCodegen.ex :: Run Codegen from #{file}")

    CodeConfig.load_config(file)
    |> IO.inspect(label: "Run Codegen from this config")
    |> run_codegen
  end

  @doc """
  Execute MixCodegen using the supplied configuration passed in as a Map.
  """
  @spec run_codegen(map) :: :ok
  def run_codegen(config \\ %{}) do
    # IO.inspect(config, label: "MixCodegen::run_codegen config #{inspect(config)}")

    Enum.map(config, fn task ->
      # IO.inspect(task["task"], label: "MixCodegen::run_codegen task #{inspect(task["task"])}")

      # IO.inspect(Mix.Task.get("codegen.ecto.migration"), label: "MixCodegen::run_codegen task.get")

      module = Mix.Task.get(task["task"])
      IO.inspect(module, label: "MixCodegen::run_codegen module")
      codegen_fun = &module.run_codegen/1

      IO.inspect(codegen_fun, label: "MixCodegen::run_codegen codegen_fun")

      Enum.each(task["run"], fn run ->
        codegen_fun.(run)
      end)
    end)
  end
end
