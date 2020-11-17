require Logger

dir = Application.get_env(:erga, :uploads_directory)

if dir do
  # dir happends to be nil in some case wich would resoult in an error

  Logger.info("Deleting upload directory './#{dir}':")
  File.rm_rf!(dir)
  |> Enum.each(fn item -> Logger.info(item) end)
end
