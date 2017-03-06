defmodule ElixirStation.Router do
  use ElixirStation.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:3000"]
    plug :accepts, ["json"]
  end

  scope "/", ElixirStation do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", ElixirStation do
      pipe_through :api

      resources "/board", BoardController
  end
end
