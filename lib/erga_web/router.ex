defmodule ErgaWeb.Router do
  use ErgaWeb, :router
  use Pow.Phoenix.Router
  import Phoenix.LiveView.Router


  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug :fetch_live_flash
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:put_root_layout, {ErgaWeb.LayoutView, :root})
    plug(ErgaWeb.Gettext.Plug)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :protected do
    plug(Pow.Plug.RequireAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler)
  end

  scope "/" do
    pipe_through :browser

    pow_session_routes()
  end

  scope "/", ErgaWeb do
    pipe_through [:browser, :protected]

    get("/", ProjectController, :index)

    resources("/projects", ProjectController)
    resources("/person", PersonController,                          only: [:create, :delete, :edit, :new, :update, :index])
    resources("/stakeholders", StakeholderController,               only: [:create, :delete, :edit, :new, :update])
    resources("/external_links", ExternalLinkController,            only: [:create, :delete, :edit, :new, :update])
    resources("/images", ImageController,                           only: [:create, :delete, :edit, :new, :update])
    resources("/translated_contents", TranslatedContentController,  only: [:create, :delete, :edit, :new, :update])

    resources("/linked_resource", LinkedResourceController, only: [ :delete ])

    put("/locale", LocaleController, :set)

    live "/linked_resources/new/:project_id", LinkedResourceLive, :new
    live "/linked_resources/:id/edit", LinkedResourceLive, :edit
    #live "/linked_resources/:id/delete", LinkedResourceLive.Index, :delete

  end

  # Other scopes may use custom stacks.
  scope "/api", ErgaWeb.Api, as: :api do
    pipe_through(:api)

    get("/projects/code/:code", ProjectController, :show)
    resources("/projects", ProjectController, only: [:show, :index])
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:browser, :protected]
      live_dashboard(
        "/dashboard",
        metrics: ErgaWeb.Telemetry,
        ecto_repos: [Erga.Repo]
      )
    end
  end
end
