defmodule EventHandler do
  import Phoenix.LiveView, only: [assign: 3, update: 3]
  alias Erga.Research.TranslatedContent



  def form_change(target, %{"linked_resource" => params}, socket) do
    case target do
      "linked_system" ->
        update(socket, :uri, fn _ -> "" end)
        |> update(:search_result, fn _ -> [] end)
        |> update(:linked_system, fn _ -> params["linked_system"] end)
      "search_string" ->
        search(socket, params["search_string"])
      target ->
        update(socket, String.to_existing_atom(target), fn _ -> params[target] end)
    end
  end

  def choose_resource( %{"id" => id, "name" => name, "uri" => uri}, socket) do
    socket
      |> update(:label, fn _ -> name end)
      |> update(:linked_id, fn _ -> id end)
      |> update(:uri, fn _ -> uri end)
      |> update(:search_string, fn _ -> "" end)
      |> update(:search_result, fn _ -> [] end)
  end

  def add_description(%{"language-code" => language_code, "text" => text}, socket) do

    new_description = %TranslatedContent{
      language_code: language_code,
      text: text
    }

    socket
    |> update(:descriptions, fn existing_descriptions -> existing_descriptions ++ [new_description] end)
  end

  defp search(socket, search_string) do
    service = ServiceHelpers.get_system_service(socket.assigns.linked_system)
    filter = socket.assigns.search_filter
    # permit users to use wildcard on thier own
    search_string = String.replace_trailing(search_string, "*", "")

    # perform a search or return empty list
    if String.length(search_string) > 1 do
      case service.get_list(search_string, filter) do
        {:ok, list} -> update(socket, :search_result, fn _old_search_string -> list end)
        {:error, reason} -> assign(socket, :search_error, reason)
      end
    else
      update(socket, :search_result, fn _l -> [] end)
    end
  end

end
