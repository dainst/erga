defmodule ErgaWeb.ExternalLinkLive.Show do
  use ErgaWeb, :live_view
  use Phoenix.HTML

  alias Erga.Research

  def render(assigns) do
    Phoenix.View.render(ErgaWeb.ExternalLinkView, "show.html", assigns)
  end

  def mount(%{"id" => id}, _session, socket) do
    try do
      external_link = Research.get_external_link!(id)

      socket =
        socket
        |> assign(:external_link, external_link)

      {:ok, socket}
    rescue Ecto.NoResultsError ->
      socket =
        socket
        |> put_flash(:info, "No External link with that id")
        |> redirect(to: "/external_links")
      {:ok, socket}
    end

  end

  def get_resource_name(resId, system_name) do
    system_service = ServiceHelpers.get_system_service(system_name)
    system_service.get_by_id(resId).name
  end


end
