defmodule LeroyJenkins.SessionController do
  use LeroyJenkins.Web, :controller

  alias LeroyJenkins.Session

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: Session.changeset(%Session{})
  end

  def create(conn, %{"session" => session_params}) do
    changeset = Session.changeset(%Session{}, session_params)

    if changeset.valid? do
      conn
      |> put_session(:current_user, "i-am-a-secured-user")
      |> put_flash(:info, "Logado com sucesso!")
      |> redirect(to: form_path(conn, :index))
    else
      conn
      |> put_session(:current_user, nil)
      |> put_flash(:error, "VERY WRONG PASSWORD!!")
      |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Hasta la vista baby!")
    |> redirect(to: session_path(conn, :new))
  end
end
