defmodule Erga.StaffTest do
  use Erga.DataCase

  alias Erga.Staff

  describe "stakeholders" do
    alias Erga.Staff.Stakeholder

    @valid_attrs %{
      title: "some title",
      first_name: "some first_name",
      last_name: "some last_name",
      orc_id: "some orc id",
      organization_name: "some organization name",
      ror_id: "some ror id"
    }
    @update_attrs %{
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      title: "some updated title",
      orc_id: "another orc id",
      organization_name: "another organization name",
      ror_id: "another ror id"
    }

    @invalid_attrs %{
      first_name: nil,
      last_name: nil,
      title: nil,
      orc_id: nil,
      organization_name: nil,
      ror_id: nil
    }

    defp without_associations(stakeholder) do
      Map.delete(stakeholder, :stakeholder_to_projects)
    end

    def stakeholder_fixture(attrs \\ %{}) do
      {:ok, stakeholder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Staff.create_stakeholder()

      stakeholder
    end

    test "list_stakeholders/0 returns all stakeholders" do
      stakeholder =
        stakeholder_fixture()
        |> without_associations

      stakeholder_list =
        Staff.list_stakeholders()
        |> Enum.map(&without_associations/1)

      assert stakeholder_list == [stakeholder]
    end

    test "get_stakeholder!/1 returns the stakeholder with given id" do
      stakeholder =
        stakeholder_fixture()
        |> without_associations

      stakeholder_loaded =
        Staff.get_stakeholder!(stakeholder.id)
        |> without_associations
      assert stakeholder == stakeholder_loaded
    end

    test "create_stakeholder/1 with valid data creates a stakeholder" do
      assert {:ok, %Stakeholder{} = stakeholder} = Staff.create_stakeholder(@valid_attrs)
      assert stakeholder.first_name == "some first_name"
      assert stakeholder.last_name == "some last_name"
      assert stakeholder.title == "some title"
      assert stakeholder.orc_id == "some orc id"
      assert stakeholder.organization_name == "some organization name"
      assert stakeholder.ror_id == "some ror id"
    end

    test "create_stakeholder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_stakeholder(@invalid_attrs)
    end

    test "update_stakeholder/2 with valid data updates the stakeholder" do
      stakeholder = stakeholder_fixture()
      assert {:ok, %Stakeholder{} = stakeholder} = Staff.update_stakeholder(stakeholder, @update_attrs)
      assert stakeholder.first_name == "some updated first_name"
      assert stakeholder.last_name == "some updated last_name"
      assert stakeholder.title == "some updated title"
      assert stakeholder.orc_id == "another orc id"
      assert stakeholder.organization_name == "another organization name"
      assert stakeholder.ror_id == "another ror id"
    end

    test "update_stakeholder/2 with invalid data returns error changeset" do
      stakeholder =
        stakeholder_fixture()
        |> without_associations

      assert {:error, %Ecto.Changeset{}} = Staff.update_stakeholder(stakeholder, @invalid_attrs)

      stakeholder_loaded =
        Staff.get_stakeholder!(stakeholder.id)
        |> without_associations

      assert stakeholder == stakeholder_loaded
    end

    test "delete_stakeholder/1 deletes the stakeholder" do
      stakeholder = stakeholder_fixture()
      assert {:ok, %Stakeholder{}} = Staff.delete_stakeholder(stakeholder)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_stakeholder!(stakeholder.id) end
    end

    test "change_stakeholder/1 returns a stakeholder changeset" do
      stakeholder = stakeholder_fixture()
      assert %Ecto.Changeset{} = Staff.change_stakeholder(stakeholder)
    end
  end

  describe "stakeholder_roles" do
    alias Erga.Staff.StakeholderRole

    @valid_attrs %{tag: "some tag"}
    @update_attrs %{tag: "some updated tag"}
    @invalid_attrs %{tag: nil}

    def stakeholder_role_fixture(attrs \\ %{}) do
      {:ok, stakeholder_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Staff.create_stakeholder_role()

      stakeholder_role
      |> Erga.Repo.preload(:role_to_projects)
    end

    test "list_stakeholder_roles/0 returns all stakeholder_roles" do
      stakeholder_role = stakeholder_role_fixture()
      assert Staff.list_stakeholder_roles() == [stakeholder_role]
    end

    test "get_stakeholder_role!/1 returns the stakeholder_role with given id" do
      stakeholder_role = stakeholder_role_fixture()
      assert Staff.get_stakeholder_role!(stakeholder_role.id) == stakeholder_role
    end

    test "create_stakeholder_role/1 with valid data creates a stakeholder_role" do
      assert {:ok, %StakeholderRole{} = stakeholder_role} = Staff.create_stakeholder_role(@valid_attrs)
      assert stakeholder_role.tag == "some tag"
    end

    test "create_stakeholder_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_stakeholder_role(@invalid_attrs)
    end

    test "update_stakeholder_role/2 with valid data updates the stakeholder_role" do
      stakeholder_role = stakeholder_role_fixture()
      assert {:ok, %StakeholderRole{} = stakeholder_role} = Staff.update_stakeholder_role(stakeholder_role, @update_attrs)
      assert stakeholder_role.tag == "some updated tag"
    end

    test "update_stakeholder_role/2 with invalid data returns error changeset" do
      stakeholder_role = stakeholder_role_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_stakeholder_role(stakeholder_role, @invalid_attrs)
      assert stakeholder_role == Staff.get_stakeholder_role!(stakeholder_role.id)
    end

    test "delete_stakeholder_role/1 deletes the stakeholder_role" do
      stakeholder_role = stakeholder_role_fixture()
      assert {:ok, %StakeholderRole{}} = Staff.delete_stakeholder_role(stakeholder_role)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_stakeholder_role!(stakeholder_role.id) end
    end

    test "change_stakeholder_role/1 returns a stakeholder_role changeset" do
      stakeholder_role = stakeholder_role_fixture()
      assert %Ecto.Changeset{} = Staff.change_stakeholder_role(stakeholder_role)
    end
  end
end
