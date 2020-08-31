defmodule ThesaurusService do
  use HTTPoison.Base


  @base_url "http://thesauri.dainst.org/de/search.ttl?q="

  @query """
  select *
  where {
    ?s ?p ?o
  }
  """

  def get_list(val) do
    res =
      HTTPoison.get!(@base_url <> val).body
      |> RDF.Turtle.read_string!
      |> SPARQL.execute_query(@query)
    #  |> Map.get("result")
    res
   # get_result_list(res)
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
