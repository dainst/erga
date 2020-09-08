defmodule GazetteerService do
  use StandardServiceBehaivour

  @base_url  "https://gazetteer.dainst.org/search.json?q="

  def get_list(val) do
    get_list_request(@base_url <> val <> "*" <> "&offset=0&limit=10", "result")
  end

  def get_by_id(id) do
    if String.to_integer(id) |> is_number do
      HTTPoison.start

      case HTTPoison.get(@base_url <> id) do
        {:ok, response} -> item = response.body
                                  |> Poison.decode!
                                  |> Map.get("result")
                                  |> get_result_list
                                  |> List.first
                                  {:ok, item}
        {:error, reason} -> {:error, "There was an error during the request: " <> Atom.to_string(reason.reason)}
      end

    else
      raise(ArgumentError, message: "id not a number: " <> to_string(id))
    end

  end

  def get_result_list(res) do
    if is_list(res) do
      for n <- res, do: %{name: n["prefName"]["title"], resId: n["gazId"]}
    else
      []
    end
  end
end
