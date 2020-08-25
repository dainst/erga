defmodule ErgaWeb.Router do
  use ErgaWeb, :router

  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug :fetch_live_flash
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug :put_root_layout, {ErgaWeb.LayoutView, :app}
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ErgaWeb do
    pipe_through(:browser)

    resources("/projects", ProjectController)

    # TODO: Nötig? Man könnte den reroute auch darüber lösen dass man die id vorm löschen ausliest.
    delete("/stakeholders/:id/:project_id", StakeholderController, :delete)
    get("/stakeholders/new/:project_id", StakeholderController, :new)

    # TODO: Nötig? Man könnte den reroute auch darüber lösen dass man die id vorm löschen ausliest.
    #delete("/linked_resources/:id/:project_id", LinkedResourceController, :delete)
    #get("/linked_resources/new/:project_id", LinkedResourceController, :new)

    live "/linked_resources/new/:project_id", LinkedResourceLive.New
    live "/linked_resources", LinkedResourceLive.Index
    live "/linked_resources/:id", LinkedResourceLive.Show
    live "/linked_resources/:id/edit", LinkedResourceLive.Edit

    live "/persons", PersonLive.Index, :index
    live "/persons/new", PersonLive.Index, :new
    live "/persons/:id/edit", PersonLive.Index, :edit

    live "/persons/:id", PersonLive.Show, :show
    live "/persons/:id/show/edit", PersonLive.Show, :edit

    post "/linked_resources/new/:project_id", LinkedResourceController, :create

    resources("/stakeholders", StakeholderController)
    #resources("/linked_resources", LinkedResourceController)
    resources("/images", ImageController)
    resources("/translated_contents", TranslatedContentController)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/api", ErgaWeb.Api, as: :api do
    pipe_through(:api)

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
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: ErgaWeb.Telemetry)
    end
  end
end
