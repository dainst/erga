defmodule Erga.Research.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @upload_directory Application.get_env(:erga, :uploads_directory)

  schema "images" do
    field(:label, :string)
    field(:path, :string)
    field(:primary, :boolean)

    belongs_to(:project, Erga.Research.Project)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:label, :path, :primary])
    |> validate_file(attrs)
    |> validate_required([:label, :path, :primary])
    |> cast_assoc(:project)
  end

  def validate_file(changeset, %{"upload" => upload} = attrs) do
    project_directory = attrs["project_code"]
    target_directory = "#{@upload_directory}/#{project_directory}"
    File.mkdir_p(target_directory)

    target_file = "#{target_directory}/#{upload.filename}"

    if File.exists?(target_file) do
      add_error(
        changeset,
        :path,
        "File #{upload.filename} already exists in #{project_directory}."
      )
    else
      File.cp!(
        upload.path,
        target_file
      )

      put_change(changeset, :path, "#{project_directory}/#{upload.filename}")
    end
  end

  def validate_file(changeset, %{"path" => path}) do
    if !File.exists?("#{@upload_directory}/#{path}") do
      add_error(changeset, :path, "File #{path} does not exists!")
    end

    changeset
  end

  def validate_file(changeset, _attrs) do
    changeset
  end
end
