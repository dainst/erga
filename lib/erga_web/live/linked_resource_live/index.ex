defmodule ErgaWeb.LinkedResourceLive.Index do
  use Phoenix.LiveView

  alias Erga.Research
  alias ErgaWeb.LinkedResourceView
  alias ErgaWeb.Router.Helpers, as: Routes

  def render(assigns), do: LinkedResourceView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    linked_resources = Research.list_linked_resources()
    socket =
      socket
      |> assign(:linked_resources, linked_resources)

    {:ok, socket}
  end

  def handle_event("delete_resource", %{"id" => id}, socket) do
    resource = Research.get_linked_resource!(id)
    {:ok, _user} = Research.delete_linked_resource(resource)

    {:noreply, socket}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
  end
  defp go_page(socket, _page), do: socket
end
