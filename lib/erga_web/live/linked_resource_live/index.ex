defmodule ErgaWeb.LinkedResourceLive.Index do
  use ErgaWeb, :live_view

  alias Erga.Research
  alias ErgaWeb.LinkedResourceView
  alias ErgaWeb.Router.Helpers, as: Routes

  def render(assigns), do: LinkedResourceView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    linked_resources = Research.list_linked_resources()
    projects = Research.list_projects()
    project_list = ["All": 0] ++ for pro <- projects, do: {List.first(pro.title).content, pro.id}

    socket =
      socket
      |> assign(:linked_resources, linked_resources)
      |> assign(:project, "0")
      |> assign(:project_list, project_list)


    {:ok, socket}
  end

  def handle_event("delete_resource", %{"id" => id}, socket) do
    resource = Research.get_linked_resource!(id)
    {:ok, _resource} = Research.delete_linked_resource(resource)
    linked_resources = Research.list_linked_resources()
    socket =
      socket
      |> assign(:linked_resources, linked_resources)
    {:noreply, socket}
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

end
