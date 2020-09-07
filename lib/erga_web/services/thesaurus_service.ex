defmodule ThesaurusService do
  use HTTPoison.Base


  @base_search_url "http://thesauri.dainst.org/de/search.ttl?q="

  @base_single_value "http://thesauri.dainst.org"

  @query """
  PREFIX sdc: <http://sindice.com/vocab/search#>
  PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
  PREFIX skosxl: <http://www.w3.org/2008/05/skos-xl#>

  select ?label ?link
  where {
    ?s skosxl:xllabel ?label .
    ?s sdc:link ?link .
  }
  """

  def get_list(val) do
    HTTPoison.start()
    case HTTPoison.get(@base_search_url <> val) do
      {:ok, response} -> list = response.body
                          |> RDF.Turtle.read_string!
                          |> SPARQL.execute_query(@query)
                          |> get_result_list
                          {:ok, list}
      {:error, reason} -> {:error, "Error during search: " <> Atom.to_string(reason.reason)}
    end
  end

  def get_by_id(id) do
    HTTPoison.start
    res =
        HTTPoison.get!(@base_single_value <> id <> ".ttl").body
        |> RDF.Turtle.read_string!
        |> SPARQL.execute_query(@query)

    List.first(get_result_list(res))
  end

  defp get_result_list(result) do
    res = result.results
    for n <- res, do: get_values(n)
  end

  defp get_values(n) do
    name = RDF.Literal.value(n["label"])
    link = RDF.IRI.parse(n["link"])
          |> URI.parse
    %{name: name , resId: link.path }
  end


end
