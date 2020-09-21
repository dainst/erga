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

    socket =
      socket
      |> assign(external_link: external_link)
      |> assign(changeset: changeset)

    {:noreply, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.ExternalLinkView, "edit.html", assigns)

  def handle_event("validate", %{"external_link" => external_link_params}, socket) do
    socket = EventHandler.validate(external_link_params, socket)
    {:noreply, socket}
  end

  def handle_event("save", %{"external_link" => external_link_params}, socket) do
    case Research.update_external_link(socket.assigns.external_link, external_link_params) do
      {:ok, external_link} ->
        {:noreply,
        socket
        |> put_flash(:info, "External Link updated successfully.")
        |> redirect(to: Routes.live_path(socket, ExternalLinkLive.Show, external_link))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
