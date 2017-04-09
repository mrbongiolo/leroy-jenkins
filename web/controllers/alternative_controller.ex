defmodule LeroyJenkins.AlternativeController do
  use LeroyJenkins.Web, :controller

  alias LeroyJenkins.Form
  alias LeroyJenkins.Alternative

  plug :scrub_params, "alternative" when action in [:create, :update]

  def create(conn, %{"form_id" => form_id, "alternative" => alternative_params}) do
    form = Repo.get!(Form, form_id)
    alternatives = assoc(form, :alternatives)
      |> Alternative.count_answers
      |> Repo.all
    changeset = form
      |> build_assoc(:alternatives)
      |> Alternative.changeset(alternative_params)

    case Repo.insert(changeset) do
      {:ok, _alternative} ->
        conn
        |> put_flash(:info, "Alternative created successfully.")
        |> redirect(to: form_path(conn, :show, form))
      {:error, changeset} ->
        render(conn, LeroyJenkins.FormView,
          "show.html",
          form: form,
          alternatives: alternatives,
          alternative_changeset: changeset)
    end
  end

  def delete(conn, %{"form_id" => form_id, "id" => id}) do
    form = Repo.get!(Form, form_id)
    assoc(form, :alternatives)
    |> Repo.get!(id)
    |> Repo.delete!
    conn
    |> put_flash(:info, "Deleted alternative")
    |> redirect(to: form_path(conn, :show, form))
  end
end
