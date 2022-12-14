defmodule RumblWeb.Router do
  use RumblWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RumblWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RumblWeb.Auth, repo: Rumbl.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RumblWeb do
    pipe_through :browser


    get "/", PageController, :index

    #rolesroute
    get "/roles", RoleController, :index

    get "/roles/new", RoleController, :new
    post "/roles/new", RoleController, :create
    get "/roles/:id/edit", RoleController, :edit
    get "/roles/:id", RoleController, :show
    put "/roles/:id/edit", RoleController, :update
    delete "/roles/:id/delete", RoleController, :delete

    #permissionroute
    get "/permissions", PermissionController, :index

    get "/permissions/new", PermissionController, :new
    post "/permissions/new", PermissionController, :create
    get "/permissions/:id/edit", PermissionController, :edit
    get "/permissions/:id", PermissionController, :show
    put "/permissions/:id/edit", PermissionController, :update
    delete "/permissions/:id/delete", PermissionController, :delete


    #sessionroute
    get "/signup", SessionController, :rregister
    post "/signup", SessionController, :register
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    #userroute
    resources "/users", UserController, only: [:index, :show, :new, :create, :delete]

  end

  scope "/manage", RumblWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", RumblWeb do
  #   pipe_through :api
  # end

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
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RumblWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
