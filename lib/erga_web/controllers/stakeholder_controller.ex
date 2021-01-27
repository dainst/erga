defmodule ErgaWeb.StakeholderController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.Stakeholder
  alias Erga.Staff

  def new(conn, %{"project_id" => project_id}) do
    changeset =
      Research.change_stakeholder(%Stakeholder{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    persons = Staff.list_persons()
    stakeholder_roles = Staff.list_stakeholder_roles()
    render(
      conn,
      "new.html",
      changeset: changeset,
      persons: persons,
      stakeholder_roles: stakeholder_roles,
      project_id: project_id
    )
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"stakeholder" => stakeholder_params}) do
    case Research.create_stakeholder(stakeholder_params) do
      {:ok, stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder created successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, stakeholder.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        persons = Staff.list_persons()
        stakeholder_roles = Staff.list_stakeholder_roles()
        render(
          conn,
          "new.html",
          changeset: changeset,
          persons: persons,
          stakeholder_roles: stakeholder_roles,
          project_id: stakeholder_params["project_id"]
        )
    end
  end

  def edit(conn, %{"id" => id}) do
    stakeholder = Research.get_stakeholder!(id)
    changeset = Research.change_stakeholder(stakeholder)
    persons = Staff.list_persons()
    stakeholder_roles = Staff.list_stakeholder_roles()
    render(
      conn,
      "edit.html",
      stakeholder: stakeholder,
      changeset: changeset,
      persons: persons,
      stakeholder_roles: stakeholder_roles,
      project_id: stakeholder.project_id
    )
  end

  def update(conn, %{"id" => id, "stakeholder" => stakeholder_params}) do
    stakeholder = Research.get_stakeholder!(id)

    case Research.update_stakeholder(stakeholder, stakeholder_params) do
      {:ok, stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder updated successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, stakeholder.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        persons = Staff.list_persons()
        stakeholder_roles = Staff.list_stakeholder_roles()
        render(
          conn,
          "edit.html",
          stakeholder: stakeholder,
          changeset: changeset,
          persons: persons,
          stakeholder_roles: stakeholder_roles,
          project_id: stakeholder.project_id
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    stakeholder = Research.get_stakeholder!(id)
    {:ok, _stakeholder} = Research.delete_stakeholder(stakeholder)

    conn
    |> put_flash(:info, "Stakeholder deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, stakeholder.project_id))
  end
end
