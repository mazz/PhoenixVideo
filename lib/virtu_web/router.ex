defmodule VirtuWeb.Router do
  use VirtuWeb, :router

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

  scope "/", VirtuWeb do
    pipe_through :browser # Use the default browser stack

    get "/", VideoController, :index
    resources "/videos", VideoController
    get "/watch/:id", WatchController, :show

  end

  # Other scopes may use custom stacks.
  # scope "/api", VirtuWeb do
  #   pipe_through :api
  # end
end
