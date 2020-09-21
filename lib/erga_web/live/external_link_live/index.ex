defmodule ErgaWeb.ExternalLinkLive.Index do
  use ErgaWeb, :live_view

  alias Erga.Research
  alias ErgaWeb.ExternalLinkView
  alias ErgaWeb.Router.Helpers, as: Routes

  def render(assigns), do: ExternalLinkView.render("index.html", assigns)

  def mount(_params, _session, socket) do
    external_links = Research.list_external_links()
    projects = Research.list_projects()
    project_list = ["All": 0] ++ for pro <- projects, do: {pro.title, pro.id}

    socket =
      socket
      |> assign(:external_links, external_links)
      |> assign(:project, "0")
      |> assign(:project_list, project_list)


    {:ok, socket}
  end

  def handle_event("delete_resource", %{"id" => id}, socket) do
    resource = Research.get_external_link!(id)
    {:ok, _resource} = Research.delete_external_link(resource)
    external_links = Research.list_external_links()
    socket =
      socket
      |> assign(:external_links, external_links)
    {:noreply, socket}
  end

  def handle_event("load_resources", %{"foo" => params}, socket) do
    IO.inspect(params)
    pid = String.to_integer(params["project"])
    socket = if pid > 0 do
      project = Research.get_project!(pid)
      IO.inspect(project)
      socket
        |> assign(:external_links, project.external_links )
        |> assign(:project, pid )
    else
      external_links = Research.list_external_links()
      socket
        |> assign(:external_links, external_links )
        |> assign(:project, "0")
    end

    {:noreply, socket}
  end

end
