

defmodule ErgaWeb.ExternalLinkLive.Search do
  use ErgaWeb, :live_view
  use Phoenix.HTML

  def render(assigns) do
    ~L"
    <%= label :search_label, :linked_id %>
    <%= text_input :search_box, :linked_id, [value: @external_link, phx_keyup: 'search_resource'] %>
    <%= @external_link %>
    "
  end

  def mount(_param, _session, socket) do
    socket =
      socket
      |> assign(:external_link, "none")
    {:ok, socket}
  end



end
