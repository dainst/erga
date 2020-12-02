defmodule ErgaWeb.LinkedResourceLive do
  use ErgaWeb, :live_view

  alias Erga.Research
  alias Erga.Research.LinkedResource

  def mount(%{"project_id" => project_id}, _session, socket) do
    # new case
    changeset =
      Research.change_linked_resource(%LinkedResource{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    socket =
      socket
      |> assign(page_title: "New Linked Resource")
      |> assign(project_id: project_id)
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:label, "")
      |> assign(:uri, "")
      |> assign(:search_result, [])
      |> assign(:search_string, "")
      |> assign(:search_filter, "populated-place")
    {:ok, socket}
  end

  def mount(%{"id" => id}, _url, socket) do
    # edit case
    linked_resource = Research.get_linked_resource!(id)
    changeset = Research.change_linked_resource(linked_resource)
    socket =
      socket
      |> assign(page_title: "Edit Linked Resource")
      |> assign(project_id: linked_resource.project_id)
      |> assign(linked_resource: linked_resource)
      |> assign(changeset: changeset)
      |> assign(:linked_system, linked_resource.linked_system)
      |> assign(:label, linked_resource.label)
      |> assign(:uri, linked_resource.uri)
      |> assign(:search_string, "")
      |> assign(:search_result, [])
      |> assign(:search_filter, "populated-place")

    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "edit.html", assigns)

  @spec handle_event(<<_::32, _::_*8>>, map, Phoenix.LiveView.Socket.t()) :: {:noreply, any}
  def handle_event("form_change", params, socket) do
    {:noreply, EventHandler.form_change(params, socket)}
  end

  def handle_event("choose_resource", params, socket) do
    {:noreply, EventHandler.choose_resource(params, socket)}
  end

  def handle_event("save", %{"linked_resource" => linked_resource_params}, socket) do
    case socket do
      %{assigns: %{live_action: :edit}} ->
          Research.update_linked_resource(socket.assigns.linked_resource, linked_resource_params)
          |> process_action_result("Linked resource updated successfully.", socket)
      %{assigns: %{live_action: :new}} ->
          Research.create_linked_resource(linked_resource_params)
          |> process_action_result("Linked resource created successfully.", socket)
    end
  end

  defp process_action_result(result, flash_msg, socket) do
    case result do
      {:ok, linked_resource} ->
        {:noreply,
        socket
        |> put_flash(:info, flash_msg)
        |> redirect(to: Routes.project_path(ErgaWeb.Endpoint, :edit, linked_resource.project_id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
