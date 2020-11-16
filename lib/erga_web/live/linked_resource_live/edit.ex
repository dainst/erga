defmodule ErgaWeb.LinkedResourceLive.Edit do
  use ErgaWeb, :live_view
  require Logger

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
      |> assign(project_id: linked_resource.project_id)
      |> assign(linked_resource: linked_resource)
      |> assign(changeset: changeset)
      |> assign(:linked_system, linked_resource.linked_system)
      |> assign(:label, linked_resource.label)
      |> assign(:linked_id, linked_resource.linked_id)
      |> assign(:search_string, "")
      |> assign(:search_filter, "populated-place")

    {:noreply, socket}
  end


  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "edit.html", assigns)

  def handle_event("form_change", params, socket) do
    {:noreply, EventHandler.form_change(params, socket)}
  end

  def handle_event("choose_resource", params, socket) do
    {:noreply, EventHandler.choose_resource(params, socket)}
  end

  def handle_event("save", %{"linked_resource" => linked_resource_params}, socket) do
    case Research.update_linked_resource(socket.assigns.linked_resource, linked_resource_params) do
      {:ok, linked_resource} ->
        {:noreply,
        socket
        |> put_flash(:info, "Linked resource updated successfully.")
        |> redirect(to: Routes.project_path(ErgaWeb.Endpoint, :edit, linked_resource.project_id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
