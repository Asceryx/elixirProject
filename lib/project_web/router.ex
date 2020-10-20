defmodule ProjectWeb.Router do
  use ProjectWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ProjectWeb do
    pipe_through :browser
  end

  scope "/api", ProjectWeb do
    scope "/users" do
      get "/:userID", UserController, :getById
      get "/", UserController, :getByEmail
      post "/", UserController, :add
      put "/:userID", UserController, :edit
      delete "/:userID", UserController, :delete
    end

    scope "/workingtimes" do
      get "/:userID", WorkingtimeController, :getAll
      get "/:userID/:workingtimeID", WorkingtimeController, :getById
      post "/:userID", WorkingtimeController, :create
      put "/:id", WorkingtimeController, :update
      delete "/:id", WorkingtimeController, :delete
    end

    scope "/clocks" do
      get "/:userID", UserController, :getByUserId
      post "/:userID", UserController, :add
    end
  end
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ProjectWeb.Telemetry
    end
  end
end
