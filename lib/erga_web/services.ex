defmodule ErgaWeb.Services do

  def get_system_service(system_name) do
    case String.downcase(system_name) do
      "gazetteer" -> GazetteerService
      "chronontology" -> ChronontologyService
      "thesaurus" -> ThesaurusService
      "arachne" -> ArachneService
      _ -> raise "no matching service"
    end
  end

  @callback get_result_list(term) :: [term]

  defmacro __using__(_) do
    quote do
      @behaviour ErgaWeb.Services

      def get_list_request(url, result_name) do
        HTTPoison.start
        case HTTPoison.get(url) do
          {:ok, response} ->
            list =
              response.body
              |> Poison.decode!
              |> Map.get(result_name)
              |> get_result_list
            {:ok, list}
          {:error, reason} ->
            {:error, "Error during search: " <> Atom.to_string(reason.reason)}
        end
      end
    end
  end

end
