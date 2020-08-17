defmodule ErgaWeb.LinkedResourceLive.New do
  use Phoenix.LiveView
  require Logger

  alias ErgaWeb.LinkedResourceLive
  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Research
  alias Erga.Research.LinkedResource


  def mount(%{"project_id" => project_id}, _session, socket) do
    changeset =
      Research.change_linked_resource(%LinkedResource{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:linked_val, "")
      |> assign(:linked_id, 0)
      |> assign(:search_result, [])
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "new.html", assigns)

  def handle_event("validate", %{"linked_resource" => linked_resource_params}, socket) do
    changeset =
      %LinkedResource{}
      |> Erga.Research.change_linked_resource(linked_resource_params)
      |> Map.put(:action, :insert)

    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(:linked_system, linked_resource_params["linked_system"])

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp get_system_service(system_name) do
      case String.downcase(system_name) do
        "gazetteer" -> GazetteerService
        "chrontology" -> ChrontologyService
        _ -> raise "no matching linked system"
      end
  end

  def handle_event("choose_resource", %{"id" => id, "name" => name}, socket) do
    socket =
      socket
      |> assign(:linked_val, name)
      |> assign(:linked_id, id)

    {:noreply, socket}
  end

  def handle_event("search_resource", %{"value" => val}, socket) do

    service = get_system_service(socket.assigns.linked_system)

    # permit users to use wildcard on thier own
    val = String.replace_trailing(val, "*", "")

    # perform a search or return empty list
    response = if String.length(val) > 1 do
                  service.get_list(val)
                else
                  []
                end

    # update socket
    {:noreply, update(socket, :search_result, fn res -> response end)}
  end

  def handle_event("save", %{"linked_resource" => linked_resource_params}, socket) do
    case Research.create_linked_resource(linked_resource_params) do
      {:ok, linked_resource} ->
        {:noreply,
         socket
         |> put_flash(:info, "Linked resource created successfully.")
         |> redirect(to: Routes.live_path(socket, ErgaWeb.LinkedResourceLive.Show, linked_resource))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
