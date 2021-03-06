defmodule ThesaurusService do
  use ErgaWeb.Services

  @base_single_value "http://thesauri.dainst.org"

  @base_hierarchy_world_tree "http://thesauri.dainst.org/de/hierarchy/_fe65f286.ttl?dir=down"

  @query_label """
  PREFIX sdc: <http://sindice.com/vocab/search#>
  PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
  PREFIX skosxl: <http://www.w3.org/2008/05/skos-xl#>

  select ?label
  where {
    ?s skosxl:literalForm ?label .
  }
  """


  def get_list(val, _filter) do
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
    hierarchy =
      case Cachex.get(:data_cache, {__MODULE__, :thesaurus_hierarchy}) do
        {:ok, nil} ->
          hier = HTTPoison.get(@base_hierarchy_world_tree, %{}, [recv_timeout: 24000, timeout: 24000])
          Cachex.put(:data_cache, {__MODULE__, :thesaurus_hierarchy}, hier)
          hier
        {:ok, hier} -> hier
      end
    case hierarchy  do
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
