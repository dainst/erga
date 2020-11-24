# defmodule ErgaWeb.PersonLiveTest do
#   use ErgaWeb.ConnCase

#   import Phoenix.LiveViewTest

#   alias Erga.Staff

#   @create_attrs %{firstname: "Santa", lastname: "Claus", title: "Weihni"}
#   @update_attrs %{firstname: "Joe", lastname: "Biden", title: "Präs."}
#   @invalid_attrs %{firstname: nil, lastname: nil, title: nil}

#   defp fixture(:person) do
#     {:ok, person} = Staff.create_person(@create_attrs)
#     person
#   end

#   defp create_person(_) do
#     person = fixture(:person)
#     %{person: person}
#   end

#   describe "Index" do
#     setup [:create_person]



#     test "lists all persons", %{conn: conn, person: person} do

#       {:ok, _index_live, html} = live(conn, Routes.person_index_path(conn, :index))

#       assert html =~ "Listing Persons"
#       assert html =~ person.firstname
#     end

#      test "saves new person", %{conn: conn} do
#        {:ok, index_live, _html} = live(conn, Routes.person_index_path(conn, :index))

#        assert index_live |> element("a", "New Person") |> render_click() =~
#                 "New Person"

#       assert_patch(index_live, Routes.person_index_path(conn, :new))

#       assert index_live
#              |> form("#person-form", person: @invalid_attrs)
#              |> render_change() =~ "can&apos;t be blank"

#       {:ok, _, html} =
#         index_live
#         |> form("#person-form", person: @create_attrs)
#         |> render_submit()
#         |> follow_redirect(conn, Routes.person_index_path(conn, :index))

#       assert html =~ "Person created successfully"
#       assert html =~ "Santa"
#     end

#     test "updates person in listing", %{conn: conn, person: person} do
#       {:ok, index_live, _html} = live(conn, Routes.person_index_path(conn, :index))

#       assert index_live |> element("#person-#{person.id} a", "Edit") |> render_click() =~
#                "Edit Person"

#       assert_patch(index_live, Routes.person_index_path(conn, :edit, person))

#       assert index_live
#              |> form("#person-form", person: @invalid_attrs)
#              |> render_change() =~ "can&apos;t be blank"

#       {:ok, _, html} =
#         index_live
#         |> form("#person-form", person: @update_attrs)
#         |> render_submit()
#         |> follow_redirect(conn, Routes.person_index_path(conn, :index))

#       assert html =~ "Person updated successfully"
#       assert html =~ "Joe"
#     end

#     test "deletes person in listing", %{conn: conn, person: person} do
#       {:ok, index_live, _html} = live(conn, Routes.person_index_path(conn, :index))

#       assert index_live |> element("#person-#{person.id} a", "Delete") |> render_click()
#       refute has_element?(index_live, "#person-#{person.id}")
#     end
#   end

#   describe "Show" do
#     setup [:create_person]

#     test "displays person", %{conn: conn, person: person} do
#       {:ok, _show_live, html} = live(conn, Routes.person_show_path(conn, :show, person))

#       assert html =~ "Show Person"
#       assert html =~ person.firstname
#     end

#     test "updates person within modal", %{conn: conn, person: person} do
#       {:ok, show_live, _html} = live(conn, Routes.person_show_path(conn, :show, person))

#       assert show_live |> element("a", "Edit") |> render_click() =~
#                "Edit Person"

#       assert_patch(show_live, Routes.person_show_path(conn, :edit, person))

#       assert show_live
#              |> form("#person-form", person: @invalid_attrs)
#              |> render_change() =~ "can&apos;t be blank"

#       {:ok, _, html} =
#         show_live
#         |> form("#person-form", person: @update_attrs)
#         |> render_submit()
#         |> follow_redirect(conn, Routes.person_show_path(conn, :show, person))

#       assert html =~ "Person updated successfully"
#       assert html =~ "Joe"
#     end
#    end
# end
