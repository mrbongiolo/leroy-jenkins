defmodule LeroyJenkins.PageController do
  use LeroyJenkins.Web, :controller

  plug LeroyJenkins.Authenticate

  def index(conn, _params) do
    render conn, "index.html"
  end
end
