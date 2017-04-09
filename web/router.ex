defmodule LeroyJenkins.Router do
  use LeroyJenkins.Web, :router

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

  scope "/", LeroyJenkins do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/forms", FormController do
      resources "/alternatives", AlternativeController,
        only: [:create, :delete]
    end

    resources "/alternatives", AlternativeController, only: [] do
      resources "/answers", AnswerController,
        only: [:new, :create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LeroyJenkins do
  #   pipe_through :api
  # end
end
