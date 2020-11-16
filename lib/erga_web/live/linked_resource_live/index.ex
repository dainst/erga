defmodule ErgaWeb.LinkedResourceLive.Index do
  use ErgaWeb, :live_view

  alias Erga.Research
  alias ErgaWeb.LinkedResourceView
  alias ErgaWeb.Router.Helpers, as: Routes





  def mount(_params, _session, socket) do
    linked_resources = Research.list_linked_resources()
    projects = Research.list_projects()
    IO.inspect(projects)
    project_list = ["All": 0] ++ for pro <- projects, do: {List.first(pro.title).content, pro.id}

    socket =
      socket
      |> assign(:linked_resources, linked_resources)
      |> assign(:project, "0")
      |> assign(:project_list, project_list)


    {:ok, socket}
  end


  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :delete, %{"id" => id, "project_id" => pid}) do
    case delete_resource(id) do
      {:ok, _} ->
        socket
        |> put_flash(:info, "Linked Resource deleted successfully.")
        |> redirect(to: Routes.project_path(socket, :edit, pid))
    end
  end

  def render(assigns) do
    LinkedResourceView.render("index.html", assigns)
  end

  def handle_event("delete_resource", %{"id" => id}, socket) do
    case delete_resource(id) do
      {:ok, _} ->
        linked_resources = Research.list_linked_resources()
        socket =
          socket
          |> assign(:linked_resources, linked_resources)
        {:noreply, socket}
    end
  end

  def handle_event("load_resources", %{"foo" => params}, socket) do
    pid = String.to_integer(params["project"])
    socket = if pid > 0 do
      project = Research.get_project!(pid)
      socket
        |> assign(:linked_resources, project.linked_resources )
        |> assign(:project, pid )
    else
      linked_resources = Research.list_linked_resources()
      socket
        |> assign(:linked_resources, linked_resources )
        |> assign(:project, "0")
    end

    {:noreply, socket}
  end

  defp delete_resource(id) do
    resource = Research.get_linked_resource!(id)
    Research.delete_linked_resource(resource)
  end

end
