# Script for adding a new User. You can run it as:
#
#     mix run priv/repo/create_user.exs "email@adress.com" "password"

alias Erga.Accounts.User


Erga.Repo.insert!(%User{
  email: Enum.at(System.argv(), 0),
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash(Enum.at(System.argv(), 1))
})
