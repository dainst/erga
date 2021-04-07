defmodule ThesaurusService do
  use ErgaWeb.Services

  @base_search_url "http://thesauri.dainst.org/de/search.ttl?q="

  @base_single_value "http://thesauri.dainst.org"

  @base_hierarchy_world_tree "http://thesauri.dainst.org/de/hierarchy/_fe65f286.ttl?dir=down"

  HTTPoison.start()
  @hierarchy HTTPoison.get("http://thesauri.dainst.org/de/hierarchy/_fe65f286.ttl?dir=down", %{}, [recv_timeout: 24000, timeout: 24000])

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

  @query_label """
  PREFIX sdc: <http://sindice.com/vocab/search#>
  PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
  PREFIX skosxl: <http://www.w3.org/2008/05/skos-xl#>

  select ?label
  where {
    ?s skosxl:literalForm ?label .
  }
  """


  def get_list(val, %{use_hierarchy: true}) do
    search_query = "
      PREFIX sdc: <http://sindice.com/vocab/search#>
      PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
      PREFIX skosxl: <http://www.w3.org/2008/05/skos-xl#>

      SELECT ?label ?link
      WHERE {

        ?s skosxl:prefLabel ?link .
        ?s skos:prefLabel ?label .
        FILTER regex(?label, \"#{val}\", \"i\")
      }
    "

    case @hierarchy  do
      {:ok, response} ->
        list =
          response.body
          |> RDF.Turtle.read_string!
          |> SPARQL.execute_query(search_query)
          |> get_result_list
        {:ok, list}
      {:error, reason} ->
        {:error, "Error during search: #{reason.reason}"}
    end
  end

  def get_list(val, _filter) do
    case HTTPoison.get("#{@base_search_url}#{val}") do
      {:ok, response} ->
        list =
          response.body
          |> RDF.Turtle.read_string!
          |> SPARQL.execute_query(@query)
          |> get_result_list
        {:ok, list}
      {:error, reason} ->
        {:error, "Error during search: #{reason.reason}"}
    end
  end

  def get_by_id(id) do
    case HTTPoison.get("#{@base_single_value}#{id}.ttl") do
      {:ok, response} ->
        items =
          response.body
          |> RDF.Turtle.read_string!
          |> SPARQL.execute_query(@query_label)

        item = List.first(
          for n <- items do
            %{name: RDF.Literal.value(n["label"]), res_id: id, uri: id}
          end)

        {:ok, item}
      {:error, reason} ->
        {:error, "Error during request " <> Atom.to_string(reason.reason)}
    end
  end

  def get_result_list(result) do
    res = result.results
    for n <- res, do: get_values(n)
  end

  defp get_values(n) do
    name = RDF.Literal.value(n["label"])
    link =
      RDF.IRI.parse(n["link"])
      |> URI.parse

    %{
      name: name ,
      res_id: link.path,
      uri: RDF.IRI.to_string(n["link"])
     }
  end

  def get_resource_id_from_uri(uri) do
    case uri do
      "http://thesauri.dainst.org/" <> id ->
        id
      _ ->
        :error
    end
  end
end
