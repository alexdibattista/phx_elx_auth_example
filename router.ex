defmodule ElxAuthWeb.Router do
  use ElxAuthWeb, :router

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

  scope "/", ElxAuthWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  
  scope "/auth", ElxAuthWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/identity/callback/", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

end
