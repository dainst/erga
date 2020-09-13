defmodule ErgaWeb.LinkedResourceLive.Show do
  use ErgaWeb, :live_view
  use Phoenix.HTML

  alias Erga.Research

  def render(assigns) do
    Phoenix.View.render(ErgaWeb.LinkedResourceView, "show.html", assigns)
  end

  def mount(%{"id" => id}, _session, socket) do
    try do
      linked_resource = Research.get_linked_resource!(id)

      socket =
        socket
        |> assign(:linked_resource, linked_resource)

      {:ok, socket}
    rescue Ecto.NoResultsError ->
      socket =
        socket
        |> put_flash(:info, "No Linked Resource with that id")
        |> redirect(to: "/linked_resources")
      {:ok, socket}
    end

  end

  def get_resource_name(resId, system_name) do
    if resId do
      system_service = ServiceHelpers.get_system_service(system_name)
      system_service.get_by_id(resId).name
    end
  end


end
