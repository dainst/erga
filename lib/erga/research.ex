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
    |> Repo.preload(linked_resources: [:labels, :descriptions])
    |> Repo.preload(external_links: :labels)
    |> Repo.preload(images: :labels)
    |> Repo.preload(:titles)
    |> Repo.preload(:descriptions)
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
    |> Repo.preload(linked_resources: [:labels, :descriptions])
    |> Repo.preload(external_links: :labels)
    |> Repo.preload(images: :labels)
    |> Repo.preload(:titles)
    |> Repo.preload(:descriptions)
  end

  @doc """
  Gets a single project based on its project code.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!("PROJECT-123")
      %Project{}

      iex> get_project!("Project-321")
      ** (Ecto.NoResultsError)

  """
  def get_project_by_code!(code) do
    Repo.one!(from(p in Project, where: p.project_code == ^code))
    |> Repo.preload(stakeholders: :person)
    |> Repo.preload(linked_resources: [:labels, :descriptions])
    |> Repo.preload(external_links: :labels)
    |> Repo.preload(images: :labels)
    |> Repo.preload(:titles)
    |> Repo.preload(:descriptions)
  end

  def get_project_by_code(code) do
    Repo.one(from(p in Project, where: p.project_code == ^code))
    |> Repo.preload(stakeholders: :person)
    |> Repo.preload(linked_resources: [:labels, :descriptions])
    |> Repo.preload(external_links: :labels)
    |> Repo.preload(images: :labels)
    |> Repo.preload(:titles)
    |> Repo.preload(:descriptions)
  end

  @spec get_project_code(any) :: {:error, <<_::104>>} | {:ok, any}
  def get_project_code(id) do
    try do
      case Repo.one(from(p in Project, select: %{code: p.project_code}, where: p.id == ^id)) do
        %{ code: code } -> {:ok, code}
        nil -> {:error, "nothing found"}
      end
    rescue
      _e in Ecto.Query.CastError -> {:error, "nothing found"}
    end
  end

  @doc """
  returns a list of all projects that where updated since a given ISO Date
  """

  def get_projects_updated_since(%NaiveDateTime{} = date) do

    Repo.all from p in Project,
          left_join: t in assoc(p, :titles),
          left_join: d in assoc(p, :descriptions),
          left_join: s in assoc(p, :stakeholders),
          left_join: pe in assoc(s, :person),
          left_join: l in assoc(p, :linked_resources),
          left_join: d_l in assoc(l, :descriptions),
          left_join: e in assoc(p, :external_links),
          left_join: i in assoc(p, :images),
          where: p.updated_at >= ^date
            or t.updated_at >= ^date
            or d.updated_at >= ^date
            or s.updated_at >= ^date
            or pe.updated_at >= ^date
            or l.updated_at >= ^date
            or d_l.updated_at >= ^date
            or e.updated_at >= ^date
            or i.updated_at >= ^date,
          preload: [titles: t, descriptions: d, external_links: e, images: i],
          preload: [stakeholders: {s, person: pe}],
          preload: [linked_resources: {l, descriptions: d_l}]
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
  Gets a single linked_resource.

  Raises `Ecto.NoResultsError` if the Linked resource does not exist.

  ## Examples

      iex> get_linked_resource!(123)
      %LinkedResource{}

      iex> get_linked_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_linked_resource!(id) do
    Repo.get!(LinkedResource, id)
    |> Repo.preload(:project)
    |> Repo.preload(:labels)
    |> Repo.preload(:descriptions)
  end

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
  Gets a single external_link.

  Raises `Ecto.NoResultsError` if the external link does not exist.

  ## Examples

      iex> get_external_link!(123)
      %LinkedResource{}

      iex> get_external_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_external_link!(id) do
    Repo.get!(ExternalLink, id)
    |> Repo.preload(:labels)
  end


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
  def create_stakeholder(attrs) do

    %Stakeholder{}
    |> Stakeholder.changeset(attrs)
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
  def get_image!(id) do
    Repo.get!(Image, id)
    |> Repo.preload(:labels)
  end

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


  defp get_schema_based_on_table_name(name) do
    Application.spec(:erga, :modules)
    |> Enum.find(fn module ->
      function_exported?(module, :__schema__, 1) && module.__schema__(:source) == name
    end)
  end

  defp validate_schema_field(target_schema, target_field_name) do
    # Do not cast Atom type based on request parameter without first checking if the Atom type is really
    # used in the requested schema.
    known_target_field =
      target_schema
      |> Map.from_struct
      |> Map.keys
      |> Enum.map(&Atom.to_string(&1))
      |> Enum.filter(fn key -> key == target_field_name end)
      |> length()

    if known_target_field == 1 do
      {:ok, String.to_atom(target_field_name)}
    else
      {:error, "Unknown field #{target_field_name} for schema #{target_schema}"}
    end
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
    |> update_translation_target(attrs)
  end

  defp update_translation_target({:error, changeset}, _attrs) do
    {:error, changeset}
  end

  defp update_translation_target({:ok, translated_content}, attrs) do
    target_schema = get_schema_based_on_table_name(attrs["target_table"])
    target = Repo.get!(target_schema, attrs["target_table_primary_key"])

    # Do not cast Atom type based on request parameter without first checking if the Atom type is really
    # used in the requested schema.

    case validate_schema_field(target_schema, attrs["target_field"]) do
      {:ok, target_field} ->
        # Set target_id in target table
        target
        |> target_schema.changeset(%{})
        |> Ecto.Changeset.put_change(target_field, translated_content.target_id)
        |> Repo.update()

        {:ok, translated_content }
      {:error, _message} ->
        translated_content
        |> Repo.delete

        changeset =
          TranslatedContent.changeset(translated_content, %{})
          |> Ecto.Changeset.add_error(
              :target_field_not_found,
              "Failed to set #{ attrs["target_field"]} in #{attrs["target_table"]}."
            )

        {:error, changeset}
    end

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
  def delete_translated_content(
    %TranslatedContent{} = translated_content,
    %{
      "target_table" => target_table,
      "target_field" => target_field
    }) do

    result = Repo.delete(translated_content)

    translations_remaining_with_target_id =
      from(q in "translated_contents", select: q.target_id, where: q.target_id == ^translated_content.target_id)
      |> Repo.all()
      |> Enum.count

    if translations_remaining_with_target_id == 0 do
      target_schema = get_schema_based_on_table_name(target_table)
      {:ok, target_field} = validate_schema_field(target_schema, target_field)

      Repo.update_all(
        from(q in target_schema,
        where: ^[{target_field, translated_content.target_id}]
      ), set: [{target_field, nil}])

    end
    result
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
