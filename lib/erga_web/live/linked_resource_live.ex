defmodule ErgaWeb.LinkedResourceLive do
  use ErgaWeb, :live_view

  alias Erga.Research
  alias Erga.Research.LinkedResource

  def handle_params(_unsigned_params, uri, socket) do
    {:noreply, assign(socket, request_path: URI.parse(uri).path)}
  end

  defp apply_default_assigns(socket) do
    socket
    |> assign(:search_result, [])
    |> assign(:search_string, "")
    |> assign(:linked_id, nil)
    |> assign(:search_filter, "populated-place")
  end

  def mount(%{"project_id" => project_id}, _session, socket) do
    # new case
    changeset =
      Research.change_linked_resource(%LinkedResource{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    socket =
      socket
      |> assign(page_title: "New Linked Resource")
      |> apply_default_assigns()
      |> assign(project_id: project_id)
      |> assign(descriptions: [])
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:label, "")
      |> assign(:uri, "")

    {:ok, socket}
  end

  def mount(%{"id" => id}, _session, socket) do
    # edit case
    linked_resource = Research.get_linked_resource!(id)
    changeset = Research.change_linked_resource(linked_resource)
    socket =
      socket
      |> assign(page_title: "Edit Linked Resource")
      |> apply_default_assigns()
      |> assign(linked_resource: linked_resource)
      |> assign(project_id: linked_resource.project_id)
      |> assign(descriptions: linked_resource.descriptions)
      |> assign(changeset: changeset)
      |> assign(:linked_system, linked_resource.linked_system)
      |> assign(:label, linked_resource.label)
      |> assign(:uri, linked_resource.uri)

    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "form.html", assigns)

  def handle_event("form_change", %{"_target" => ["linked_resource", target]} = params, socket) do
    {:noreply, EventHandler.form_change(target, params, socket)}
  end

  def handle_event("form_change", %{"_target" => [target]} = params, socket) do
    {:noreply, EventHandler.form_change(target, params, socket)}
  end

  def handle_event("form_change", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("choose_resource", params, socket) do
    {:noreply, EventHandler.choose_resource(params, socket)}
  end

  # new case
  def handle_event(
    "save",
    %{"linked_resource" => linked_resource_params},
    %{assigns: %{live_action: :new}} = socket
    ) do
    case Research.create_linked_resource(linked_resource_params) do
      {:ok, linked_resource} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Linked resource created successfully. You may add descriptions.")
          |> redirect(to: Routes.linked_resource_path(ErgaWeb.Endpoint, :edit, linked_resource.id))
        }
      {:error, changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # edit case
  def handle_event(
    "save",
    %{"linked_resource" => linked_resource_params},
    %{assigns: %{live_action: :edit}} = socket
    ) do
    case Research.update_linked_resource(socket.assigns.linked_resource, linked_resource_params) do
      {:ok, linked_resource} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Linked resource updated successfully.")
          |> redirect(to: Routes.project_path(ErgaWeb.Endpoint, :edit, linked_resource.project_id))
        }
      {:error, changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
