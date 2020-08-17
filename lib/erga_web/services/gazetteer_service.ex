defmodule GazetteerService do


  @base_url  "https://gazetteer.dainst.org/search.json?q="

  def get_list(val) do
    HTTPoison.start
    res =
      HTTPoison.get!(@base_url <> val <> "*" <> "&sort=prefName.title.sort&offset=0&limit=10").body
      |> Poison.decode!
      |> Map.get("result")

    get_result_list(res)
  end

  def get_by_id(id) do
    if String.to_integer(id) |> is_number do
      HTTPoison.start
      res =
        HTTPoison.get!(@base_url <> id).body
        |> Poison.decode!
        |> Map.get("result")

      List.first(get_result_list(res))
    else
      raise(ArgumentError, message: "id not a number: " <> to_string(id))
    end

  end

  defp get_result_list(res) do
    for n <- res, do: %{name: n["prefName"]["title"], resId: n["gazId"]}
  end



end
