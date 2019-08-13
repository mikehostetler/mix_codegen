defmodule MixCodegen do
  @moduledoc """
  Documentation for MixCodegen.
  """
  require IEx

  alias MixCodegen.Config, as: CodeConfig

  @doc """
  Execute MixCodegen based on either a file passed as input, or the :default
  codegen where a default config file is used
  """
  @spec codegen_from_file(:default | String.t()) :: :ok
  def codegen_from_file(file \\ :default) do
    CodeConfig.load_config(file)
    |> run_codegen
  end

  @doc """
  Execute MixCodegen using the supplied configuration passed in as a Map.
  """
  @spec run_codegen(map) :: :ok
  def run_codegen(config \\ []) do
    # Shortcut
    config = Application.get_all_env(:mix_codegen)

    Enum.map(config, fn {task, runs} ->
      module = Mix.Task.get(task)

      if module != nil do
        codegen_fun = &module.run/1

        Enum.each(runs, fn run ->
          codegen_fun.(run)
        end)
      end
    end)
  end
end
