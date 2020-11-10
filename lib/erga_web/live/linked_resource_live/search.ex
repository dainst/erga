

defmodule ErgaWeb.LinkedResourceLive.Search do
  use ErgaWeb, :live_view
  use Phoenix.HTML

  def render(assigns) do
    ~L"
    <%= label :search_label, :linked_id %>
    <%= text_input :search_box, :linked_id, [value: @linked_resource, phx_keyup: 'search_resource'] %>
    <%= @linked_resource %>
    "
  end

  def mount(_param, _session, socket) do
    socket =
      socket
      |> assign(:linked_resource, "none")
    {:ok, socket}
  end
end
