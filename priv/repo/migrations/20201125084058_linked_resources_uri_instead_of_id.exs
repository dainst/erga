defmodule Erga.Repo.Migrations.LinkedResourcesUriInsteadOfId do
  use Ecto.Migration

  def change do
    rename table("linked_resources"), :linked_id, to: :uri
  end
end
