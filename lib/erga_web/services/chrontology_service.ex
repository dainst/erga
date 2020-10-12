defmodule ChrontologyService do
  use StandardServiceBehaivour

  @base_url  "https://chronontology.dainst.org/data/period/"

  def get_list(val) do
    url = @base_url <> "?q=" <> val <> "*"
    get_list_request(url, "results")
  end

  def get_by_id(id) do
    HTTPoison.start
    case HTTPoison.get(@base_url <> id) do
      {:ok, response} -> item = response.body
                        |> Poison.decode!
                        |> List.wrap
                        |> get_result_list
                        |> List.first
                        {:ok, item}
      {:error, reason} -> {:error, "There was an error during the request: " <> Atom.to_string(reason.reason)}
    end

  end

  def get_result_list(res) do
    if is_list(res) do
      for  n <- res do
        names = if n["resource"]["names"]["de"], do: Enum.join( n["resource"]["names"]["de"], ", "), else: ""
        %{name: names, resId: n["resource"]["id"]}
      end
    else
      []
    end

  end


end
