defmodule Erga.Repo do
  use Ecto.Repo,
    otp_app: :erga,
    adapter: Ecto.Adapters.Postgres
end
