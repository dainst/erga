defmodule Erga.Staff.Institution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field :type, :string, default: "Institution"
    field :organization_name, :string
    field :ror_id, :string

    has_many(:stakeholder_to_projects, Erga.Research.ProjectToStakeholder)
    timestamps()
  end

  @doc false
  def changeset(institution, attrs) do
    institution
    |> cast(attrs, [
      :type,:organization_name, :ror_id
      ])
    |> evaluate_field_combination(attrs)
    |> evaluate_external_ids(attrs)
    |> cast_assoc(:stakeholder_to_projects)
  end

  def evaluate_field_combination(changeset, _attrs) do
    cond do
      not is_nil(get_field(changeset, :ror_id)) && is_nil(get_field(changeset, :organization_name)) ->
        changeset
        |> add_error(:organization_name, "Please provide organization name when setting RORID.")

      [:organization_name, :ror_id]
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
    cond do
      not is_nil(get_field(changeset, :ror_id)) && not String.match?(get_field(changeset, :ror_id), ~r/^https:\/\/ror.org\/0[^ILO]{6}[0-9]{2}$/) ->
        changeset
        |> add_error(:ror_id, "Not a valid RORID, expected pattern: 'https://ror.org/0XXXXXXXX'")

      true ->
        changeset
    end
  end
end
