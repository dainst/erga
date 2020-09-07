defmodule ErgaWeb.ImageController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.Image

  def index(conn, _params) do
    images = Research.list_images()
    render(conn, "index.html", images: images)
  end

  def new(conn, %{"project_id" => project_id}) do
    changeset =
      Research.change_image(%Image{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => image_params}) do
    project = Research.get_project!(image_params["project_id"])
    image_params = Map.put(image_params, "project_code", project.project_code)

    case Research.create_image(image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, image.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Research.get_image!(id)
    project = Research.get_project!(image.project_id)
    render(conn, "show.html", image: image, project: project)
  end

  def edit(conn, %{"id" => id}) do
    image = Research.get_image!(id)
    changeset = Research.change_image(image)
    render(conn, "edit.html", image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Research.get_image!(id)

    case Research.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: Routes.image_path(conn, :show, image))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Research.get_image!(id)
    {:ok, _image} = Research.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, image.project_id))
  end
end
