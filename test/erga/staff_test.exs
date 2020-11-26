defmodule Erga.StaffTest do
  use Erga.DataCase

  alias Erga.Staff

  describe "persons" do
    alias Erga.Staff.Person

    @valid_attrs %{firstname: "some first_name", lastname: "some lastname", title: "some title"}
    @update_attrs %{firstname: "some updated first_name", lastname: "some updated lastname", title: "some updated title"}
    @invalid_attrs %{firstname: nil, lastname: nil, title: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Staff.create_person()

      person
    end

    test "list_persons/0 returns all persons" do
      person = person_fixture()
      assert Staff.list_persons() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Staff.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Staff.create_person(@valid_attrs)
      assert person.firstname == "some firstname"
      assert person.lastname == "some lastname"
      assert person.title == "some title"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = Staff.update_person(person, @update_attrs)
      assert person.firstname == "some updated firstname"
      assert person.lastname == "some updated lastname"
      assert person.title == "some updated title"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_person(person, @invalid_attrs)
      assert person == Staff.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Staff.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Staff.change_person(person)
    end
  end
end
