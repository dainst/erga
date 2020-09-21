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
      |> assign(:label, "")
      |> assign(:url, "")
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.ExternalLinkView, "new.html", assigns)

  def handle_event("validate", %{"external_link" => external_link_params}, socket) do
    socket = EventHandler.validate(external_link_params, socket)
    {:noreply, socket}
  end


  def handle_event("save", %{"external_link" => external_link_params}, socket) do
    case Research.create_external_link(external_link_params) do
      {:ok, external_link} ->
        {:noreply,
         socket
         |> put_flash(:info, "External Link created successfully.")
         |> redirect(to: Routes.live_path(socket, ErgaWeb.ExternalLinkLive.Show, external_link))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
