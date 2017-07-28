defmodule PhoenixVideoStream.Router do
  use PhoenixVideoStream.Web, :router

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

  scope "/", PhoenixVideoStream do
    pipe_through :browser # Use the default browser stack

    get "/", VideoController, :index
    resources "/", VideoController
    get "/watch/:id", WatchController, :show
  end

  scope "/auth", MyApp do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/identity/callback", AuthController, :identity_callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixVideoStream do
  #   pipe_through :api
  # end
end
