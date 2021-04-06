defmodule ChronontologyService do
  use ErgaWeb.Services

  @base_url "https://chronontology.dainst.org"
  @data_base_url "#{@base_url}/data/period/"
  @uri_base_url "#{@base_url}/period/"

  def get_list(val, _filter) do
    url = '#{@data_base_url}?q=#{val}*%20AND%20Chronontology'
    get_list_request(url, "results")
  end

  def get_by_id(id) do
    case HTTPoison.get("#{@data_base_url}#{id}") do
      {:ok, response} ->
        item =
          response.body
          |> Poison.decode!
          |> List.wrap
          |> get_result_list
          |> List.first
        {:ok, item}
      {:error, reason} ->
        {:error, "There was an error during the request: #{reason.reason}"}
    end
  end

  def get_result_list(res) do
    if is_list(res) do
      for  n <- res do
        names = if n["resource"]["names"]["de"], do: Enum.join( n["resource"]["names"]["de"], ", "), else: ""
        %{
          name: names,
          res_id: n["resource"]["id"],
          uri: "#{@uri_base_url}#{n["resource"]["id"]}"
        }
      end
    else
      []
    end
  end

  def get_resource_id_from_uri(uri) do
    case uri do
      "https://chronontology.dainst.org/period/" <> id ->
        id
      _ ->
        :error
    end
  end
end
