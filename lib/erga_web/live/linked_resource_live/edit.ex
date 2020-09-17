defmodule ErgaWeb.LinkedResourceLive.Edit do
  use ErgaWeb, :live_view
  require Logger


  alias ErgaWeb.LinkedResourceLive
  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Research

  def mount(_params, _session, socket) do

    # load the name of the ressource
    {:ok, assign(socket, search_result: [])}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    linked_resource = Research.get_linked_resource!(id)
    changeset = Research.change_linked_resource(linked_resource)

    socket =
      socket
      |> assign(linked_resource: linked_resource)
      |> assign(changeset: changeset)
      |> assign(:linked_system, linked_resource.linked_system)
      |> assign(:linked_val, linked_resource.label)
      |> assign(:linked_id, linked_resource.linked_id)

    {:noreply, socket}
  end


  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "edit.html", assigns)

  def handle_event("validate", %{"linked_resource" => linked_resource_params}, socket) do
    socket = EventHandler.validate(linked_resource_params, socket)
    {:noreply, socket}
  end

  def handle_event("choose_resource", %{"id" => id, "name" => name}, socket) do
    socket =
      socket
      |> assign(:linked_val, name)
      |> assign(:linked_id, id)

    {:noreply, socket}
  end

  def handle_event("search_resource", %{"value" => val}, socket) do

    service = ServiceHelpers.get_system_service(socket.assigns.linked_system)

    # permit users to use wildcard on thier own
    val = String.replace_trailing(val, "*", "")

    # perform a search or return empty list
    if String.length(val) > 1 do
      case service.get_list(val) do
        {:ok, list} -> {:noreply, update(socket, :search_result, fn _old_val -> list end)}
        {:error, reason} -> {:noreply, assign(socket, :search_error, reason)}
      end
    else
      {:noreply, update(socket, :search_result, fn _l -> [] end)}
    end
  end

  def handle_event("save", %{"linked_resource" => linked_resource_params}, socket) do
    case Research.update_linked_resource(socket.assigns.linked_resource, linked_resource_params) do
      {:ok, linked_resource} ->
        {:noreply,
        socket
        |> put_flash(:info, "Linked resource updated successfully.")
        |> redirect(to: Routes.live_path(socket, LinkedResourceLive.Show, linked_resource))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
