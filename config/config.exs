# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :erga,
  ecto_repos: [Erga.Repo]

# Configures the endpoint
config :erga, ErgaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Dy2WoJA6V/7pbrZIKBSgdq5Jrsfrw/nh7k4cI8HrB35lORWsOg/cHpd8YExykZkw",
  render_errors: [view: ErgaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Erga.PubSub,
  live_view: [signing_salt: "EhZ1uJis"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :gettext,
  default_locale: "de",
  locales: ["de", "en", "fr", "it", "es", "ru"]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, :adapter, Tesla.Adapter.Hackney


config :erga, :pow,
  user: Erga.Accounts.User,
  repo: Erga.Repo,
  web_module: ErgaWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
