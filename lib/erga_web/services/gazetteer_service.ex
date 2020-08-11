defmodule GazetteerService do


  @base_url  "https://gazetteer.dainst.org/search.json?q="

  def get_list(val) do
    HTTPoison.start
    res =
      HTTPoison.get!(@base_url <> val <> "*" <> "&sort=prefName.title.sort&offset=0&limit=10").body
      |> Poison.decode!
      |> Map.get("result")

    for  n <- res, do: %{name: n["prefName"], resId: n["gazId"]}
  end

  def get_by_id(id) do
    if String.to_integer(id) |> is_number do
      HTTPoison.start
      res =
        HTTPoison.get!(@base_url <> id).body
        |> Poison.decode!
        |> Map.get("result")

      res = for n <- res, do: %{name: n["prefName"], resId: n["gazId"]}
      List.first(res)
    else
      raise(ArgumentError, message: "id not a number: " <> to_string(id))
    end

  end



end
