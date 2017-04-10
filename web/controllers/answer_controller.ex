defmodule LeroyJenkins.AnswerController do
  use LeroyJenkins.Web, :controller

  alias LeroyJenkins.Alternative
  alias LeroyJenkins.Answer

  plug PlugXForwardedFor

  plug :scrub_params, "answer" when action in [:create]
  plug :set_remote_ip, "answer" when action in [:create]

  def new(conn, %{"alternative_id" => alternative_id}) do
    alternative =
      Repo.get!(Alternative, alternative_id)
      |> Repo.preload(:form)
    changeset =
      alternative
      |> build_assoc(:answers)
      |> Answer.changeset()
      |> Ecto.Changeset.put_change(:ip, %Postgrex.INET{address: conn.remote_ip})

    render(conn, "new.html",
      changeset: changeset,
      alternative: alternative,
      form: alternative.form)
  end

  def create(conn, %{"alternative_id" => alternative_id, "answer" => answer_params}) do
    alternative =
      Repo.get!(Alternative, alternative_id)
      |> Repo.preload(:form)
    changeset =
      alternative
      |> build_assoc(:answers, form_id: alternative.form_id)
      |> Answer.changeset(answer_params)

    case Repo.insert(changeset) do
      {:ok, _answer} ->
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: poll_results_path(conn, :results, alternative.form))
      {:error, changeset} ->
        IO.inspect changeset.errors
        render(conn, "new.html",
          changeset: changeset,
          alternative: alternative,
          form: alternative.form)
    end
  end

  def set_remote_ip(conn, param_key) do
    with_remote_ip = Map.put_new(conn.params[param_key],
      "ip", %Postgrex.INET{address: conn.remote_ip})
    params = Map.put(conn.params, param_key, with_remote_ip)
    %{conn | params: params}
  end
end
