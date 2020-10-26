# Erga

To start postgres run:
`docker-compose up`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
### Usermanagement
To create a new user,

run `mix run priv/repo/create_user.exs email@adress.com password`
### Database reset
run `mix ecto.reset`

Default User is `admin` : `erga123!`
### Seeding
run `mix run priv/repo/seeds.exs`

This will delete all entries in the database and replace them with default ones.

## Troubleshooting

### Start postgress docker

run `docker-compose up`

### Restart postgress docker

run `docker restart erga_db`

### MacOS

If the compilation went wrong try this comand to clean your installation ` mix deps.clean --all && mix deps.get`

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  * LiveView Examples: https://github.com/chrismccord/phoenix_live_view_example
