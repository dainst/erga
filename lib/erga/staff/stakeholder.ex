defmodule Erga.Staff.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field :type, Ecto.Enum, values: [:person, :institution], default: :person
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
    stakeholder
    |> cast(attrs, [
      :type, :first_name, :last_name, :title, :orc_id, :organization_name, :ror_id
    ])
    |> extract_type()
    |> evaluate_required_fields()
    |> evaluate_external_ids()
    |> cast_assoc(:stakeholder_to_projects)
  end

  defp extract_type(changeset) do
    { get_field(changeset, :type), changeset }
  end

  def evaluate_required_fields({:institution, changeset}) do

    changeset =
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

    {:institution, changeset}
  end

  def evaluate_required_fields({type_atom, changeset}) do
    changeset =
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

    {type_atom, changeset}
  end

  def evaluate_external_ids({:institution, changeset}) do
    cond do
      not is_nil(get_field(changeset, :ror_id)) && not String.match?(get_field(changeset, :ror_id), ~r/^https:\/\/ror.org\/0[^ILO]{6}[0-9]{2}$/) ->
        changeset
        |> add_error(:ror_id, "Not a valid RORID, expected pattern: 'https://ror.org/0XXXXXXXX'")

      true ->
        changeset
    end
  end

  def evaluate_external_ids({_type, changeset}) do
    cond do
      not is_nil(get_field(changeset, :orc_id)) && not String.match?(get_field(changeset, :orc_id), ~r/^https:\/\/orcid.org\/([0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4})$/) ->
        changeset
        |> add_error(:orc_id, "Not a valid ORCID, expected pattern: 'https://orcid.org/XXXX-XXXX-XXXX-XXXX'")
      true ->
        changeset
    end
  end
end
