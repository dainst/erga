defmodule Erga.Staff.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field :first_name, :string
    field :last_name, :string
    field :title, :string, default: ""
    field :orc_id, :string
    field :organization_name, :string
    field :ror_id, :string

    has_many(:stakeholder_to_projects, Erga.Research.ProjectToStakeholder)

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [
      :first_name, :last_name, :title, :orc_id, :organization_name, :ror_id
      ])
    |> evaluate_field_combination(attrs)
    |> evaluate_external_ids(attrs)
    |> cast_assoc(:stakeholder_to_projects)
  end

  def evaluate_field_combination(changeset, _attrs) do
    cond do
      not is_nil(get_field(changeset, :first_name)) && is_nil(get_field(changeset, :last_name)) ->
        changeset
        |> add_error(:last_name, "Please provide last name when setting first name.")

      not is_nil(get_field(changeset, :orc_id)) && is_nil(get_field(changeset, :last_name)) ->
        changeset
        |> add_error(:last_name, "Please provide last name when setting ORCID.")

      not is_nil(get_field(changeset, :ror_id)) && is_nil(get_field(changeset, :organization_name)) ->
        changeset
        |> add_error(:organization_name, "Please provide organization name when setting RORID.")

      [:first_name, :last_name, :orc_id, :organization_name, :ror_id]
      |> Enum.map(&get_field(changeset, &1))
      |> Enum.filter(fn val -> not is_nil(val) end)
      |> Enum.empty? ->
        changeset
        |> add_error(:general, "Please input some data.")

      true ->
        changeset
    end
  end

  def evaluate_external_ids(changeset, _attrs) do
    # TODO
    changeset
  end
end
