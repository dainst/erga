# Erga

## Setup

To start postgres run:
`docker-compose up`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](DEPLOYMENT.md).

## Usermanagement
To create a new user, run `mix run priv/repo/create_user.exs useremail userpassword`. The default User is `dev@example.com` : `erga123!`, defined in [seeds.exs](priv/repo/seeds.exs).

## Database reset
To remove all current data, apply all migrations and reseed based on [seeds.exs](priv/repo/seeds.exs) run `mix ecto.reset`. You may be unable to reset the database if it is still opened by another application (for example [pgAdmin](https://www.pgadmin.org)).

## Troubleshooting

### Dockerized PostgreSQL 

Run `docker-compose up` to start database container.

Run `docker-compose down` to stop database container.

### MacOS

If the compilation went wrong try this comand to clean your installation ` mix deps.clean --all && mix deps.get`

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
  * LiveView Examples: https://github.com/chrismccord/phoenix_live_view_example
