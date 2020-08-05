defmodule ErgaWeb.LinkedResourceLive.New do
  use Phoenix.LiveView


  alias ErgaWeb.LinkedResourceLive
  alias ErgaWeb.Router.Helpers, as: Routes
  alias Erga.Research
  alias Erga.Research.LinkedResource

  def mount(_params, _session, socket) do
    changeset = Research.change_linked_resource(%LinkedResource{})
    socket =
      socket
      |> assign(changeset: changeset)
      |> assign(:linked_system, "none")
      |> assign(:linked_val, "")
      |> assign(:search_result, [])
    {:ok, socket}
  end

  def render(assigns), do: Phoenix.View.render(ErgaWeb.LinkedResourceView, "new.html", assigns)

  def handle_event("validate", %{"linked_resource" => linked_resource_params}, socket) do
    changeset =
      %LinkedResource{}
      |> Erga.Research.change_linked_resource(linked_resource_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("search_resource", %{"value" => val}, socket) do

    response = if String.length(val) > 1 do
                  GazetteerService.start()
                  res = GazetteerService.get!(val).body[:result]
                  for  n <- res, do: n["prefName"]
                else
                  []
                end

    socket =
      socket
      |> assign(:linked_val, val)
      |> assign(:search_result, response)

    {:noreply, socket}
  end

  def handle_event("save", %{"linked_resource" => linked_resource_params}, socket) do
    case Research.create_linked_resource(linked_resource_params) do
      {:ok, linked_resource} ->
        {:stop,
         socket
         |> put_flash(:info, "Linked resource created successfully.")
         |> redirect(to: Routes.live_path(socket, LinkedResourceLive.Show, linked_resource))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
