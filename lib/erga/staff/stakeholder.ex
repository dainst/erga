defmodule Erga.Staff.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field :type, Ecto.Enum, values: [:person, :institution]
    field :first_name, :string
    field :last_name, :string
    field :title, :string, default: ""
    field :orc_id, :string
    field :organization_name, :string
    field :ror_id, :string

    has_many(:stakeholder_to_projects, Erga.Research.ProjectToStakeholder)

    timestamps()
  end

  def changeset(stakeholder, %{} = attrs) do
    IO.puts("1")
    IO.inspect(attrs)
    IO.inspect(stakeholder)
    case stakeholder.type do
      "person" ->
        stakeholder
        |> cast(attrs, [
          :type, :first_name, :last_name, :title, :orc_id, :organization_name, :ror_id
        ])
        |> person_evaluate_field_combination(attrs)
        |> person_evaluate_external_ids(attrs)
        |> cast_assoc(:stakeholder_to_projects)
      "institution" ->
        stakeholder
        |> cast(attrs, [
          :type, :first_name, :last_name, :title, :orc_id, :organization_name, :ror_id
        ])
        |> institution_evaluate_field_combination(attrs)
        |> institution_evaluate_external_ids(attrs)
        |> cast_assoc(:stakeholder_to_projects)

      _ ->
      IO.inspect(stakeholder)
        stakeholder
        |> cast(attrs, [
          :type, :first_name, :last_name, :title, :orc_id, :organization_name, :ror_id
        ])
        |> institution_evaluate_field_combination(attrs)
        |> institution_evaluate_external_ids(attrs)
        |> cast_assoc(:stakeholder_to_projects)
    end
  end
  @doc false
  def changeset(stakeholder, attrs) do
    IO.puts("2")
    case attrs["type"] do
      :person ->
        stakeholder
        |> cast(attrs, [
          :type, :first_name, :last_name, :title, :orc_id
        ])
        |> person_evaluate_field_combination(attrs)
        |> person_evaluate_external_ids(attrs)
        |> cast_assoc(:stakeholder_to_projects)
      :institution ->
        stakeholder
        |> cast(attrs, [
          :type, :organization_name, :ror_id
        ])
        |> institution_evaluate_field_combination(attrs)
        |> institution_evaluate_external_ids(attrs)
        |> cast_assoc(:stakeholder_to_projects)
    end

  end

  def person_evaluate_field_combination(changeset, _attrs) do
    cond do
      not is_nil(get_field(changeset, :first_name)) && is_nil(get_field(changeset, :last_name)) ->
        changeset
        |> add_error(:last_name, "Please provide last name when setting first name.")

      not is_nil(get_field(changeset, :orc_id)) && is_nil(get_field(changeset, :last_name)) ->
        changeset
        |> add_error(:last_name, "Please provide last name when setting ORCID.")


      [:first_name, :last_name, :orc_id]
      |> Enum.map(&get_field(changeset, &1))
      |> Enum.filter(fn val -> not is_nil(val) end)
      |> Enum.empty? ->
        changeset
        |> add_error(:general, "Please input some data.")

      true ->
        changeset
    end
  end

  def person_evaluate_external_ids(changeset, _attrs) do
    cond do
      not is_nil(get_field(changeset, :orc_id)) && not String.match?(get_field(changeset, :orc_id), ~r/^https:\/\/orcid.org\/([0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4})$/) ->
        changeset
        |> add_error(:orc_id, "Not a valid ORCID, expected pattern: 'https://orcid.org/XXXX-XXXX-XXXX-XXXX'")
      true ->
        changeset
    end
  end

  def institution_evaluate_field_combination(changeset, _attrs) do
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

  def institution_evaluate_external_ids(changeset, _attrs) do
    cond do
      not is_nil(get_field(changeset, :ror_id)) && not String.match?(get_field(changeset, :ror_id), ~r/^https:\/\/ror.org\/0[^ILO]{6}[0-9]{2}$/) ->
        changeset
        |> add_error(:ror_id, "Not a valid RORID, expected pattern: 'https://ror.org/0XXXXXXXX'")

      true ->
        changeset
    end
  end
end
