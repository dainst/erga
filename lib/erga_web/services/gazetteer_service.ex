defmodule GazetteerService do
  use ErgaWeb.Services

  @base_url  "https://gazetteer.dainst.org/search.json?add=parents&offset=0&limit=10&q="

  def get_list(val, filter) do
    case filter do
      "populated-place" -> get_list_request(@base_url <> URI.encode(val <> "* types:populated-place")  , "result")
      "building-institution" -> get_list_request(@base_url <> URI.encode(val <> "* types:building-institution")  , "result")
      "archaeological-site" -> get_list_request(@base_url <> URI.encode(val <> "* types:archaeological-site")  , "result")
      _ -> get_list_request(@base_url <> URI.encode(val <> "*") , "result")
    end

  end

  def get_by_id(id) do
    try do
      id = String.to_integer(id)
      case HTTPoison.get("#{@base_url}#{id}") do
        {:ok, response} ->
          item =
            response.body
            |> Poison.decode!
            |> Map.get("result")
            |> get_result_list
            |> List.first

          {:ok, item}
        {:error, reason} ->
          {:error, "There was an error during the request: #{reason.reason}"}
      end
    rescue
      ArgumentError -> {:error, "Id not a number: #{id}"}
    end

  end

  def get_result_list(res) do
    if is_list(res) do
      for n <- res do
        if List.first(n["parents"]) do
          %{
            name: "#{n["prefName"]["title"]} - #{List.first(n["parents"])["prefName"]["title"]}",
            res_id: n["gazId"],
            uri: n["@id"]
          }
        else
          %{
            name: n["prefName"]["title"],
            res_id: n["gazId"],
            uri: n["@id"]
          }
        end
      end
    else
      []
    end
  end

  def get_resource_id_from_uri(uri) do
    case uri do
      "https://gazetteer.dainst.org/place/" <> id ->
        id
      _ ->
        :error
    end
  end
end
