defmodule Erga.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Erga.Repo,
      # Start the Telemetry supervisor
      ErgaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Erga.PubSub},
      # Start the Endpoint (http/https)
      ErgaWeb.Endpoint
      # Start a worker by calling: Erga.Worker.start_link(arg)
      # {Erga.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Erga.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ErgaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
