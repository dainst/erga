defmodule ErgaWeb.PersonLive.Show do
  use ErgaWeb, :live_view
  import ErgaWeb.LiveHelpers
  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Staff

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:person, Staff.get_person!(id))}
  end

  defp page_title(:show), do: "Show Person"
  defp page_title(:edit), do: "Edit Person"
end
