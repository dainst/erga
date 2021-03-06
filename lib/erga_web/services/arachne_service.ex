defmodule ArachneService do
  use ErgaWeb.Services

  @base_url "https://arachne.dainst.org/data/search"

  def get_list(val, _filter) do
    case HTTPoison.get("#{@base_url}?q=#{val}*") do
      {:ok, response} ->
        list =
          response.body
          |> Poison.decode!
          |> Map.get("entities")
          |> get_result_list
        {:ok, list}
      {:error, reason} ->
        {:error, "Error during search: #{reason.reason}"}
    end
  end

  def get_by_id(id) do
    res =
      HTTPoison.get!("#{@base_url}#{id}").body
      |> Poison.decode!

    get_result_list([res])
    |> List.first
  end

  def get_result_list(res) do
    if is_list(res) do
      for  n <- res do
        name =  "#{n["type"]}: #{n["title"]}"
        %{
          name: name,
          res_id: n["entityId"],
          uri: n["@id"]
        }
      end
    else
      []
    end
  end

  def get_resource_id_from_uri(uri) do
    case uri do
      "http://arachne.dainst.org/entity/" <> id ->
        id
      _ ->
        :error
    end
  end
end
