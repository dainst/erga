defmodule ErgaWeb.ExternalLinkLive.New do
  use ErgaWeb, :live_view
  require Logger

  alias ErgaWeb.ExternalLinkLive
  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Research
  alias Erga.Research.ExternalLink


  def mount(%{"project_id" => project_id}, _session, socket) do
    changeset =
      Research.change_external_link(%ExternalLink{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(:linked_system, "gazetteer")
      |> assign(:linked_val, "")
      |> assign(:linked_id, 0)
      |> assign(:search_result, [])
      |> assign(:search_error, "")
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.ExternalLinkView, "new.html", assigns)

  @spec handle_event(<<_::32, _::_*8>>, map, %{
          __struct__: Phoenix.LiveView.Socket | Phoenix.Socket
        }) :: {:noreply, any}
  def handle_event("validate", %{"external_link" => external_link_params}, socket) do
    socket = EventHandler.validate(external_link_params, socket)
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
        {:error, reason} -> {:noreply, update(socket, :search_error, fn _old_val -> reason end)}
      end
    else
      {:noreply, update(socket, :search_result, fn _l -> [] end)}
    end
  end

  def handle_event("save", %{"external_link" => external_link_params}, socket) do
    case Research.create_external_link(external_link_params) do
      {:ok, external_link} ->
        {:noreply,
         socket
         |> put_flash(:info, "External link created successfully.")
         |> redirect(to: Routes.live_path(socket, ErgaWeb.ExternalLinkLive.Show, external_link))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
