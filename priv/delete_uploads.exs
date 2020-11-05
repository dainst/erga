require Logger

dir = Application.get_env(:erga, :uploads_directory)

Logger.info("Deleting upload directory './#{dir}':")

File.rm_rf!(dir)
|> Enum.each(fn item -> Logger.info(item) end)
