defmodule ChrontologyService do


  @base_url  "https://chronontology.dainst.org/data/period/"

  def get_list(val) do
    HTTPoison.start
    res =
      HTTPoison.get!(@base_url <> "?q=" <> val <> "*" ).body
      |> Poison.decode!
      |> Map.get("results")
    IO.inspect(res)
    get_result_list(res)
  end

  def get_by_id(id) do
    HTTPoison.start
    res =
      HTTPoison.get!(@base_url <> id).body
      |> Poison.decode!
    IO.puts(inspect(res))

    get_result_list([res])
    |> List.first
  end

  defp get_result_list(res) do
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
