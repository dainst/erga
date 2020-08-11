defmodule GazetteerService do
  use HTTPoison.Base


  @expected_fields ~w(result prefName)

  def process_request_url(url) do
    "https://gazetteer.dainst.org/search.json?q=" <> url <> "&sort=prefName.title.sort&offset=0&limit=10"
  end



end
