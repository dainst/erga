defmodule ErgaWeb.LinkedResourceLive.New do
  use ErgaWeb, :live_view
  require Logger

  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Research
  alias Erga.Research.LinkedResource

  def mount(%{"project_id" => project_id}, _session, socket) do
    changeset =
      Research.change_linked_resource(%LinkedResource{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    socket =
      socket
      |> assign(project_id: project_id)
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:label, "")
      |> assign(:linked_id, "")
      |> assign(:search_result, [])
      |> assign(:search_string, "")
      |> assign(:search_filter, "populated-place")
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "new.html", assigns)

  def handle_event("form_change", params, socket) do
    {:noreply, EventHandler.form_change(params, socket)}
  end

  def handle_event("choose_resource", params, socket) do
    {:noreply, EventHandler.choose_resource(params, socket)}
  end

  def handle_event("save", %{"linked_resource" => linked_resource_params}, socket) do
    case Research.create_linked_resource(linked_resource_params) do
      {:ok, linked_resource} ->
        {:noreply,
         socket
         |> put_flash(:info, "Linked resource created successfully.")
         |> redirect(to: Routes.project_path(ErgaWeb.Endpoint, :edit, linked_resource.project_id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
