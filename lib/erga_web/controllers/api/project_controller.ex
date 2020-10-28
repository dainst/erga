defmodule ErgaWeb.Api.ProjectController do
  use ErgaWeb, :controller

  alias Erga.Research

  def index(conn, %{"updated_days_ago" => days_ago}) do
    projects = Research.get_projects_updated_days_ago(days_ago)
    render(conn, "list.json", projects: projects)
  end

  def index(conn, %{"since"=> date_string}) do
    case parse_date(date_string) do
      {:ok, date} ->
        projects = Research.get_projects_updated_since(date)
        render(conn, "list.json", projects: projects)
      {:error, error} ->
        send_resp(conn, 400, "Malformed date: '#{date_string}'.")
    end
  end

  def index(conn, _params) do
    projects = Research.list_projects()
    render(conn, "list.json", projects: projects)
  end

  def show(conn, %{"id" => id}) do
    project = Research.get_project!(id)
    render(conn, "show.json", project: project)
  end

  defp parse_date(date_string) do
    case NaiveDateTime.from_iso8601(date_string) do
      {:error, _} ->
        case NaiveDateTime.from_iso8601("#{date_string} 00:00:00") do
          result -> result
        end
      success -> success
    end
  end
end
