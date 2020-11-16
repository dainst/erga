defmodule ErgaWeb.PersonController do
  use ErgaWeb, :controller

  alias Erga.Staff
  alias Erga.Staff.Person

  def index(conn,  %{"redirect" => redirect}) do
    persons = Staff.list_persons()
    render(conn, "index.html", persons: persons, redirect: redirect)
  end

  def new(conn, %{"redirect" => redirect}) do
    changeset = Staff.change_person(%Person{})
    render(conn, "new.html", changeset: changeset, redirect: redirect)
  end

  def create(conn, %{"person" => %{"redirect" => redirect} = person_params}) do
    case Staff.create_person(person_params) do
      {:ok, _person} ->
        conn
        |> put_flash(:info, "Person created successfully.")
        |> redirect(to: redirect)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "redirect" => redirect}) do
    person = Staff.get_person!(id)
    changeset = Staff.change_person(person)
    render(conn, "edit.html", person: person, redirect: redirect, changeset: changeset)
  end

  def update(conn, %{"id" => id, "person" => %{"redirect" => redirect} = person_params}) do
    person = Staff.get_person!(id)

    case Staff.update_person(person, person_params) do
      {:ok, _person} ->
        conn
        |> put_flash(:info, "Person updated successfully.")
        |> redirect(to: Routes.person_path(conn, :index, redirect: redirect))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", person: person, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "redirect" => redirect}) do
    person = Staff.get_person!(id)
    {:ok, _person} = Staff.delete_person(person)

    conn
    |> put_flash(:info, "Person deleted successfully.")
    |> redirect(to: Routes.person_path(conn, :index, redirect: redirect))
  end
end
