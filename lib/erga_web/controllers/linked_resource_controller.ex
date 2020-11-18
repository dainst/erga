defmodule ErgaWeb.LinkedResourceController do
  use ErgaWeb, :controller
  alias Erga.Research


  def delete(conn, %{"id" => id}) do
    
    # load resource
    resource = Research.get_linked_resource!(id)

    # save project id
    pid = resource.project.id

    # delete resource
    {:ok, _} = Research.delete_linked_resource(resource)

    # put success message and redirect to project
    conn
    |> put_flash(:info, "Linked Resource deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, pid))
  end

end
