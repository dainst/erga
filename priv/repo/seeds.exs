# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Erga.Repo.insert!(%Erga.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Erga.Accounts.User

Erga.Repo.delete_all User

Erga.Repo.insert!(%User{
  email: "dev@example.com",
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("erga123!")
})
