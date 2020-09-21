defmodule EventHandler do
  import Phoenix.LiveView, only: [assign: 3]
  alias Erga.Research.ExternalLink


  def validate(params, socket) do
      changeset =
        %ExternalLink{}
        |> Erga.Research.change_external_link(params)
        |> Map.put(:action, :insert)

      assign(socket, :changeset, changeset)

  end

end
