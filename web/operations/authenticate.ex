defmodule LeroyJenkins.Authenticate do
  import Plug.Conn
  import LeroyJenkins.Router.Helpers
  import Phoenix.Controller

  def init(args), do: args

  def call(conn, _) do
    if get_session(conn, :current_user) do
      conn
    else
      conn
      |> put_flash(:error, "Você não deveria estar aqui!")
      |> Phoenix.Controller.redirect(to: session_path(conn, :new))
      |> halt()
    end
  end
end
