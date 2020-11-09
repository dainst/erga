defmodule EventHandler do
  import Phoenix.LiveView, only: [assign: 3, update: 3]
  alias Erga.Research.LinkedResource


  def form_change(%{"_target" => targets,  "linked_resource" => params}, socket) do
      cond do
        "linked_system" in targets -> assign(socket, :linked_id, "") |> assign(:search_result, [])
        "search_filter" in targets -> assign(socket, :search_filter, params["search_filter"])
        "search_string" in targets -> search(socket, params["search_string"])
        true -> validate(params, socket)
      end
  end

  def choose_resource( %{"id" => id, "name" => name}, socket) do
    socket
      |> assign(:label, name)
      |> assign(:linked_id, id)
      |> assign(:search_string, "")
      |> assign(:search_result, [])
  end

  defp validate(params, socket) do
    changeset =
      %LinkedResource{}
      |> Erga.Research.change_linked_resource(params)
      |> Map.put(:action, :insert)

      assign(socket, :changeset, changeset)
      |> assign(:linked_system, params["linked_system"])
  end

  defp search(socket, search_string) do
    IO.inspect(socket.assigns)
    IO.inspect(search_string)
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
