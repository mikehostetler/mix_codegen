defmodule MixCodegen.Config do
  @moduledoc """
  Read and load a Mix Codegen Configuration into a Map
  """
  defmodule ConfigFile do
    @filename "codegen.exs"
    @spec custom_config_file() :: String.t()
    def custom_config_file,
      do: Application.get_env(:mix_codegen, :config_file, "#{File.cwd!()}/config/#{@filename}")

    @spec default_config_file() :: String.t()
    def default_config_file, do: Path.expand("#{__DIR__}/../../config/#{@filename}")

    @spec default_root_file() :: String.t()
    def default_root_file, do: Path.expand("#{__DIR__}/../../#{@filename}")
  end

  @doc """
  Load a config file from the specified file path. Also accepts `:default` which searches for a
  config file in the default locations and will use that if found.
  """
  @spec load_config(String.t() | :default) :: map
  def load_config(file \\ :default) do
    find_config_file(file)
    # |> IO.inspect()
    |> read_config_file
  end

  @spec read_config_file(String.t()) :: map
  defp read_config_file(config_file) do
    if File.exists?(config_file) do
      # case File.read!(config_file) |> Jason.decode() do
      case Config.Reader.read!(config_file) do
        [mix_codegen: [config]] -> config
        # {:ok, config} -> config
        _ -> raise CodegenConfigParseError
      end
    else
      Map.new()
    end
  end

  @spec find_config_file(:default) :: String.t()
  def find_config_file(:default) do
    cond do
      File.exists?(config_file = ConfigFile.custom_config_file()) -> config_file
      File.exists?(config_file = ConfigFile.default_config_file()) -> config_file
      File.exists?(config_file = ConfigFile.default_root_file()) -> config_file
      true -> raise CodegenConfigNotFound
    end
  end

  @spec find_config_file(String.t()) :: String.t()
  def find_config_file(file_path) do
    Path.expand(file_path)
    |> File.exists?()
    |> err_no_config_file(file_path)
  end

  @spec err_no_config_file(false, any()) :: none()
  defp err_no_config_file(false, _) do
    raise CodegenConfigNotFound
  end

  @spec err_no_config_file(true, String.t()) :: String.t()
  defp err_no_config_file(true, file_path), do: file_path
end

defmodule CodegenConfigNotFound do
  defexception message: "Codegen config file could not be found"
end

defmodule CodegenConfigParseError do
  defexception message: "Codegen config could not be parsed correctly"
end
