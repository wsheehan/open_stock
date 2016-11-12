defmodule OpenStock.Router do
  use OpenStock.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug OpenStock.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OpenStock do
    pipe_through [:browser, :authenticated]

    get "/", PageController, :index
    get "/:ticker", CompanyController, :show

    resources "/users", UserController, only: [:show, :new, :create]

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", OpenStock do
  #   pipe_through :api
  # end
end
