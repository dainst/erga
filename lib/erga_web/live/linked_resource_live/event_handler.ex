defmodule EventHandler do
  import Phoenix.LiveView, only: [assign: 3]
  alias Erga.Research.LinkedResource


  def change(%{"_target" => targets,  "linked_resource" => params}, socket) do
      cond do
        "linked_system" in targets -> assign(socket, :linked_id, '') |> assign(:search_result, [])
        "search_filter" in targets -> assign(socket, :search_filter, params["search_filter"])
        true -> validate(params, socket)
      end
  end

  defp validate(params, socket) do
    changeset =
      %LinkedResource{}
      |> Erga.Research.change_linked_resource(params)
      |> Map.put(:action, :insert)

      assign(socket, :changeset, changeset)
      |> assign(:linked_system, params["linked_system"])
  end

end
