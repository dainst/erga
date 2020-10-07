defmodule Erga.Research.ProjectTitleTranslations do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_title_translations" do

    timestamps()
  end

  @doc false
  def changeset(project_title_translations, attrs) do
    project_title_translations
    |> cast(attrs, [])
    |> validate_required([])
  end
end
