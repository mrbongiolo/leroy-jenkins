defmodule LeroyJenkins.Router do
  use LeroyJenkins.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :allow_embed do
    plug :delete_resp_header, "x-frame-options" # Ok, this is insecure, but we need it for now to allow embedding it in an iframe
  end

  scope "/admin", LeroyJenkins do
    pipe_through [:browser] # Use the default browser stack

    get "/", FormController, :index

    resources "/sessions", SessionController, only: [:new, :create]

    resources "/forms", FormController do
      resources "/alternatives", AlternativeController,
        only: [:create, :delete]
    end
  end

  scope "/embed", LeroyJenkins do
    pipe_through [:browser, :allow_embed]

    get "/", PollController, :index

    resources "/polls", PollController, only: [:index, :show] do
      get "/results", PollController, :results, as: :results
    end

    resources "/polls", AlternativeController, as: :poll, only: [] do
      resources "/vote", AnswerController,
        only: [:new, :create]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LeroyJenkins do
  #   pipe_through :api
  # end
end
