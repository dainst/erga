defmodule EventHandler do
  import Phoenix.LiveView, only: [assign: 3]
  alias Erga.Research.LinkedResource


  def validate(params, socket) do
      changeset =
        %LinkedResource{}
        |> Erga.Research.change_linked_resource(params)
        |> Map.put(:action, :insert)

      assign(socket, :changeset, changeset)
      |> assign(:linked_system, params["linked_system"])

  end

end
