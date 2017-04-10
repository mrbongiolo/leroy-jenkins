defmodule LeroyJenkins.PollController do
  use LeroyJenkins.Web, :controller

  alias LeroyJenkins.Form
  alias LeroyJenkins.Alternative

  def index(conn, _params) do
    forms = Repo.all(Form)
    render(conn, "index.html", forms: forms)
  end

  def show(conn, %{"id" => id}) do
    form = Repo.get!(Form, id)
    alternatives =
      assoc(form, :alternatives)
      |> Repo.all

    render(conn, "show.html", form: form, alternatives: alternatives)
  end

  def results(conn, %{"poll_id" => id}) do
    form = Repo.get!(Form, id)
    alternatives =
      assoc(form, :alternatives)
      |> Alternative.count_answers
      |> Repo.all

    render(conn, "results.html", form: form, alternatives: alternatives)
  end
end
