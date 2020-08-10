defmodule GazetteerService do
  use HTTPoison.Base


  @expected_fields ~w(result prefName)

  def process_request_url(url) do
    "https://gazetteer.dainst.org/search.json?q=" <> url <> "&sort=prefName.title.sort&offset=0&limit=10"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end


end
