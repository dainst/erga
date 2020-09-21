defmodule ErgaWeb.ExternalLinkLive.Edit do
  use ErgaWeb, :live_view
  require Logger


  alias ErgaWeb.ExternalLinkLive
  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Research
  alias Erga.Research.ExternalLink

  def mount(_params, _session, socket) do

    # load the name of the ressource
    {:ok, assign(socket, search_result: [])}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    external_link = Research.get_external_link!(id)
    changeset = Research.change_external_link(external_link)
    linked_val = loading_choosen_resource(external_link.linked_id, external_link.linked_system).name

    socket =
      socket
      |> assign(external_link: external_link)
      |> assign(changeset: changeset)
      |> assign(:linked_system, external_link.linked_system)
      |> assign(:linked_val, linked_val)
      |> assign(:linked_id, external_link.linked_id)

    {:noreply, socket}
  end

  defp loading_choosen_resource(resId, system_name) do
    system_service = ServiceHelpers.get_system_service(system_name)
    system_service.get_by_id(resId)
  end



  def render(assigns), do: Phoenix.View.render(ErgaWeb.ExternalLinkView, "edit.html", assigns)

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
    response = if String.length(val) > 1 do
                  service.get_list(val)
                else
                  []
                end

    # update socket
    {:noreply, update(socket, :search_result, fn res -> response end)}
  end

  def handle_event("save", %{"external_link" => external_link_params}, socket) do
    case Research.update_external_link(socket.assigns.external_link, external_link_params) do
      {:ok, external_link} ->
        {:noreply,
        socket
        |> put_flash(:info, "External link updated successfully.")
        |> redirect(to: Routes.live_path(socket, ExternalLinkLive.Show, external_link))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
