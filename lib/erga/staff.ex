defmodule Erga.Staff do
  @moduledoc """
  The Staff context.
  """

  import Ecto.Query, warn: false
  alias Erga.Repo

  alias Erga.Staff.Stakeholder
  alias Erga.Research.ProjectToStakeholder

  @doc """
  Returns the list of stakeholders.

  ## Examples

      iex> list_stakeholders()
      [%Stakeholder{}, ...]

  """
  def list_stakeholders do
    Repo.all(Stakeholder)
    |> Repo.preload(stakeholder_to_projects: [:project])
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
    |> Repo.preload(:stakeholder_to_projects)
  end

  @doc """
  Creates a stakeholder.

  ## Examples

      iex> create_stakeholder(%{field: value})
      {:ok, %Stakeholder{}}

      iex> create_stakeholder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stakeholder(attrs \\ %{}) do
    %Stakeholder{}
    |> Stakeholder.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:stakeholder_to_projects, with: &ProjectToStakeholder.changeset/2)
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
    stakeholder
    |> Ecto.Changeset.change
    |> Ecto.Changeset.no_assoc_constraint(:stakeholder_to_projects)
    |> Repo.delete
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stakeholder changes.

  ## Examples

      iex> change_stakeholder(stakeholder)
      %Ecto.Changeset{data: %Stakeholder{}}

  """
  def change_stakeholder(%Stakeholder{} = stakeholder, attrs \\ %{}) do
    Stakeholder.changeset(stakeholder, attrs)
  end

  alias Erga.Staff.StakeholderRole

  @doc """
  Returns the list of stakeholder_roles.

  ## Examples

      iex> list_stakeholder_roles()
      [%StakeholderRole{}, ...]

  """
  def list_stakeholder_roles do
    Repo.all(StakeholderRole)
    |> Repo.preload(role_to_projects: [:project])
  end

  @doc """
  Gets a single stakeholder_role.

  Raises `Ecto.NoResultsError` if the Stakeholder role does not exist.

  ## Examples

      iex> get_stakeholder_role!(123)
      %StakeholderRole{}

      iex> get_stakeholder_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stakeholder_role!(id) do
    Repo.get!(StakeholderRole, id)
    |> Repo.preload(:role_to_projects)
  end

  @doc """
  Creates a stakeholder_role.

  ## Examples

      iex> create_stakeholder_role(%{field: value})
      {:ok, %StakeholderRole{}}

      iex> create_stakeholder_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stakeholder_role(attrs \\ %{}) do
    %StakeholderRole{}
    |> StakeholderRole.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stakeholder_role.

  ## Examples

      iex> update_stakeholder_role(stakeholder_role, %{field: new_value})
      {:ok, %StakeholderRole{}}

      iex> update_stakeholder_role(stakeholder_role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stakeholder_role(%StakeholderRole{} = stakeholder_role, attrs) do
    stakeholder_role
    |> StakeholderRole.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stakeholder_role.

  ## Examples

      iex> delete_stakeholder_role(stakeholder_role)
      {:ok, %StakeholderRole{}}

      iex> delete_stakeholder_role(stakeholder_role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stakeholder_role(%StakeholderRole{} = stakeholder_role) do
    stakeholder_role
    |> Ecto.Changeset.change
    |> Ecto.Changeset.no_assoc_constraint(:role_to_projects)
    |> Repo.delete
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stakeholder_role changes.

  ## Examples

      iex> change_stakeholder_role(stakeholder_role)
      %Ecto.Changeset{data: %StakeholderRole{}}

  """
  def change_stakeholder_role(%StakeholderRole{} = stakeholder_role, attrs \\ %{}) do
    StakeholderRole.changeset(stakeholder_role, attrs)
  end
end
