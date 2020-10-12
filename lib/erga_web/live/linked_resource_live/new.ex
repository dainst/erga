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
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:label, "")
      |> assign(:linked_id, 0)
      |> assign(:search_result, [])
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "new.html", assigns)

  @spec handle_event(<<_::32, _::_*8>>, map, %{
          __struct__: Phoenix.LiveView.Socket | Phoenix.Socket
        }) :: {:noreply, any}
  def handle_event("validate", %{"linked_resource" => linked_resource_params}, socket) do
    socket = EventHandler.validate(linked_resource_params, socket)
    {:noreply, socket}
  end

  def handle_event("change_label", %{"value" => val}, socket) do
    socket =
      socket
      |> assign(:label, val)

    {:noreply, socket}
  end

  def handle_event("choose_resource", %{"id" => id, "name" => name}, socket) do
    socket =
      socket
      |> assign(:label, name)
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
