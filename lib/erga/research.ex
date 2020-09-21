defmodule Erga.Research do
  @moduledoc """
  The Research context.
  """
  require Logger

  import Ecto.Query, warn: false
  alias Erga.Repo

  alias Erga.Research.{Project, LinkedResource, ExternalLink, Image, Stakeholder, TranslatedContent}

  @upload_directory Application.get_env(:erga, :uploads_directory)
  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Project
    |> Repo.all()
    |> Repo.preload(:stakeholders)
    |> Repo.preload(:linked_resources)
    |> Repo.preload(:external_links)
    |> Repo.preload(:images)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id) do
    Repo.get!(Project, id)
    |> Repo.preload(stakeholders: :person)
    |> Repo.preload(:linked_resources)
    |> Repo.preload(:external_links)
    |> Repo.preload(:images)
  end

  @doc """
  returns a list of all projects that where updated x days ago
  """
  def update_days_ago(days_ago) do
    d = String.to_integer(days_ago)
    Repo.all(from(p in Project, where: p.updated_at >= ago(^d, "day")))
  end

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:stakeholders, with: &Stakeholder.changeset/2)
    |> Ecto.Changeset.cast_assoc(:linked_resources, with: &LinkedResource.changeset/2)
    |> Ecto.Changeset.cast_assoc(:external_links, with: &ExternalLink.changeset/2)
    |> Ecto.Changeset.cast_assoc(:images, with: &Image.changeset/2)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:stakeholders, with: &Stakeholder.changeset/2)
    |> Ecto.Changeset.cast_assoc(:linked_resources, with: &LinkedResource.changeset/2)
    |> Ecto.Changeset.cast_assoc(:external_links, with: &ExternalLink.changeset/2)
    |> Ecto.Changeset.cast_assoc(:images, with: &Image.changeset/2)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  @doc """
  Returns the list of linked_resources.

  ## Examples

      iex> list_linked_resources()
      [%LinkedResource{}, ...]

  """
  def list_linked_resources do
    Repo.all(LinkedResource)
  end

  @doc """
  Gets a single linked_resource.

  Raises `Ecto.NoResultsError` if the Linked resource does not exist.

  ## Examples

      iex> get_linked_resource!(123)
      %LinkedResource{}

      iex> get_linked_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_linked_resource!(id), do: Repo.get!(LinkedResource, id)

  @doc """
  Creates a linked_resource.

  ## Examples

      iex> create_linked_resource(%{field: value})
      {:ok, %LinkedResource{}}

      iex> create_linked_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_linked_resource(attrs = %{"project_id" => project_id}) do
    project = get_project!(project_id)

    %LinkedResource{}
    |> LinkedResource.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:project, project)
    |> Repo.insert()
  end

  @doc """
  Updates a linked_resource.

  ## Examples

      iex> update_linked_resource(linked_resource, %{field: new_value})
      {:ok, %LinkedResource{}}

      iex> update_linked_resource(linked_resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_linked_resource(%LinkedResource{} = linked_resource, attrs) do
    linked_resource
    |> LinkedResource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a linked_resource.

  ## Examples

      iex> delete_linked_resource(linked_resource)
      {:ok, %LinkedResource{}}

      iex> delete_linked_resource(linked_resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_linked_resource(%LinkedResource{} = linked_resource) do
    Repo.delete(linked_resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking linked_resource changes.

  ## Examples

      iex> change_linked_resource(linked_resource)
      %Ecto.Changeset{data: %LinkedResource{}}

  """
  def change_linked_resource(%LinkedResource{} = linked_resource, attrs \\ %{}) do
    LinkedResource.changeset(linked_resource, attrs)
  end

  @doc """
  Returns the list of external_links.

  ## Examples

      iex> list_external_links()
      [%ExternalLink{}, ...]

  """
  def list_external_links do
    Repo.all(ExternalLink)
  end

  @doc """
  Gets a single external_link.

  Raises `Ecto.NoResultsError` if the external link does not exist.

  ## Examples

      iex> get_external_link!(123)
      %LinkedResource{}

      iex> get_external_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_external_link!(id), do: Repo.get!(ExternalLink, id)


  @doc """
  Creates an external_link.

  ## Examples

      iex> create_external_link(%{field: value})
      {:ok, %ExternalLink{}}

      iex> create_external_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_external_link(attrs = %{"project_id" => project_id}) do
    project = get_project!(project_id)

    %ExternalLink{}
    |> ExternalLink.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:project, project)
    |> Repo.insert()
  end


  @doc """
  Updates an external_link.

  ## Examples

      iex> update_external_link(external_link, %{field: new_value})
      {:ok, %ExternalLink{}}

      iex> update_external_link(external_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_external_link(%ExternalLink{} = external_link, attrs) do
    external_link
    |> ExternalLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an external_link

  ## Examples

      iex> delete_external_link(external_link)
      {:ok, %ExternalLink{}}

      iex> delete_external_link(external_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_external_link(%ExternalLink{} = external_link) do
    Repo.delete(external_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking external_link changes.

  ## Examples

      iex> change_external_link(external_link)
      %Ecto.Changeset{data: %ExternalLink{}}

  """
  def change_external_link(%ExternalLink{} = external_link, attrs \\ %{}) do
    ExternalLink.changeset(external_link, attrs)
  end

  @doc """
  Returns the list of stakeholders.

  ## Examples

      iex> list_stakeholders()
      [%Stakeholder{}, ...]

  """
  def list_stakeholders do
    Repo.all(Stakeholder)
    |> Repo.preload(:project)
    |> Repo.preload(:person)
  end

  @doc """
  Gets a single stakeholder.

  Raises `Ecto.NoResultsError` if the Stakeholder does not exist.

  ## Examples

      iex> get_stakeholder!(123)
      %Stakeholder{}

      iex> get_stakeholder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stakeholder!(id) do
    Repo.get!(Stakeholder, id)
    |> Repo.preload(:project)
    |> Repo.preload(:person)
  end

  @doc """
  Creates a stakeholder.

  ## Examples

      iex> create_stakeholder(%{field: value})
      {:ok, %Stakeholder{}}

      iex> create_stakeholder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stakeholder(attrs = %{"project_id" => project_id}) do
    project = get_project!(project_id)

    %Stakeholder{}
    |> Stakeholder.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:project, project)
    |> Repo.insert()
  end

  @doc """
  Updates a stakeholder.

  ## Examples

      iex> update_stakeholder(stakeholder, %{field: new_value})
      {:ok, %Stakeholder{}}

      iex> update_stakeholder(stakeholder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stakeholder(%Stakeholder{} = stakeholder, attrs) do
    stakeholder
    |> Stakeholder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stakeholder.

  ## Examples

      iex> delete_stakeholder(stakeholder)
      {:ok, %Stakeholder{}}

      iex> delete_stakeholder(stakeholder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stakeholder(%Stakeholder{} = stakeholder) do
    Repo.delete(stakeholder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stakeholder changes.

  ## Examples

      iex> change_stakeholder(stakeholder)
      %Ecto.Changeset{data: %Stakeholder{}}

  """
  def change_stakeholder(%Stakeholder{} = stakeholder, attrs \\ %{}) do
    Stakeholder.changeset(stakeholder, attrs)
    |> Ecto.Changeset.cast_assoc(:project, with: &Project.changeset/2)
  end

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(attrs = %{"project_id" => project_id}) do
    project = get_project!(project_id)

    %Image{}
    |> Image.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:project, project)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    case Repo.delete(image) do
      {:ok, _struct} = result ->
        case File.rm("#{@upload_directory}/#{image.path}") do
          {:error, reason} ->
            Logger.error(
              "Failed to delete file: #{@upload_directory}/#{image.path}, reason: #{reason}."
            )
          _ -> :ok
        end

        result

      error ->
        error
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{data: %Image{}}

  """
  def change_image(%Image{} = image, attrs \\ %{}) do
    Image.changeset(image, attrs)
  end

  @doc """
  Returns the list of translated_contents.

  ## Examples

      iex> list_translated_contents()
      [%TranslatedContent{}, ...]

  """
  def list_translated_contents do
    Repo.all(TranslatedContent)
  end

  @doc """
  Gets a single translated_content.

  Raises `Ecto.NoResultsError` if the Translated content does not exist.

  ## Examples

      iex> get_translated_content!(123)
      %TranslatedContent{}

      iex> get_translated_content!(456)
      ** (Ecto.NoResultsError)

  """
  def get_translated_content!(id), do: Repo.get!(TranslatedContent, id)

  @doc """
  Creates a translated_content.

  ## Examples

      iex> create_translated_content(%{field: value})
      {:ok, %TranslatedContent{}}

      iex> create_translated_content(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_translated_content(attrs \\ %{}) do
    %TranslatedContent{}
    |> TranslatedContent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a translated_content.

  ## Examples

      iex> update_translated_content(translated_content, %{field: new_value})
      {:ok, %TranslatedContent{}}

      iex> update_translated_content(translated_content, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_translated_content(%TranslatedContent{} = translated_content, attrs) do
    translated_content
    |> TranslatedContent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a translated_content.

  ## Examples

      iex> delete_translated_content(translated_content)
      {:ok, %TranslatedContent{}}

      iex> delete_translated_content(translated_content)
      {:error, %Ecto.Changeset{}}

  """
  def delete_translated_content(%TranslatedContent{} = translated_content) do
    Repo.delete(translated_content)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking translated_content changes.

  ## Examples

      iex> change_translated_content(translated_content)
      %Ecto.Changeset{data: %TranslatedContent{}}

  """
  def change_translated_content(%TranslatedContent{} = translated_content, attrs \\ %{}) do
    TranslatedContent.changeset(translated_content, attrs)
  end
end
