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
    |> handle_upload(attrs)
    |> validate_required([:label, :path, :primary])
    |> evaluate_path(attrs)
    |> cast_assoc(:project)
  end

  def handle_upload(changeset, %{"upload" => upload} = attrs) do
    project_directory =
      attrs["project_code"]
      |> Zarex.sanitize()

    target_directory = "#{@upload_directory}/#{project_directory}"

    case File.mkdir_p(target_directory) do
      {:error, reason} ->
        add_error(
          changeset,
          :path,
          "Unable to create project upload directory: #{project_directory}, reason: #{reason}."
        )

      :ok ->
        :ok
    end

    filename =
      upload.filename
      |> Zarex.sanitize()

    target_file = "#{target_directory}/#{filename}"

    if File.exists?(target_file) do
      add_error(
        changeset,
        :path,
        "File #{upload.filename} already exists in #{project_directory}."
      )
    else
      changeset = copy_file(changeset, target_file, upload)

      put_change(changeset, :path, "#{project_directory}/#{upload.filename}")
    end
  end

  def handle_upload(changeset, _) do
    changeset
  end

  defp copy_file(changeset, target_file, %{:url => url}) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        File.write(target_file, body)
        changeset
      {:error, reason} ->
        add_error(
          changeset,
          :path,
          "Unable to download file from #{url}, reason: #{reason}."
        )
    end
  end

  defp copy_file(changeset, target_file, %{:path => path}) do
    case File.cp(
      path,
      target_file
    ) do
      {:error, reason} ->
        add_error(
          changeset,
          :path,
          "Unable to copy file #{target_file}, reason: #{reason}."
      )
      :ok -> changeset
    end
  end

  def evaluate_path(%{changes: %{path: path}} = changeset, _attrs) do
    if !File.exists?("#{@upload_directory}/#{path}") do
      add_error(changeset, :path, "File #{path} does not exists!")
    else
      changeset
    end
  end

  def evaluate_path(changeset, _attrs) do
    changeset
  end
end
