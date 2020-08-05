defmodule ErgaWeb.LinkedResourceLive.Show do
  use Phoenix.LiveView
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
        |> assign("linked_resource", linked_resource)

      {:ok, socket}
    rescue Ecto.NoResultsError ->
      socket =
        socket
        |> put_flash(:info, "No Linked Resource with that id")
        |> redirect(to: "/linked_resources")
      {:ok, socket}
    end

  end

  # def handle_params(%{"id" => id}, _url, socket) do
  #   if connected?(socket), do: Demo.Accounts.subscribe(id)
  #   {:noreply, socket |> assign(id: id) |> fetch()}
  # end

  # defp fetch(%Socket{assigns: %{id: id}} = socket) do
  #   assign(socket, user: Accounts.get_user!(id))
  # end

  # def handle_info({Accounts, [:user, :updated], _}, socket) do
  #   {:noreply, fetch(socket)}
  # end

  # def handle_info({Accounts, [:user, :deleted], _}, socket) do
  #   {:stop,
  #    socket
  #    |> put_flash(:error, "This user has been deleted from the system")
  #    |> redirect(to: Routes.live_path(socket, UserLive.Index))}
  # end
end
