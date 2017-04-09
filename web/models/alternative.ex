defmodule LeroyJenkins.Alternative do
  use LeroyJenkins.Web, :model
  import Ecto.Query

  schema "alternatives" do
    field :body, :string

    belongs_to :form, LeroyJenkins.Form

    has_many :answers, LeroyJenkins.Answer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end

  # Queries

  def count_answers(query) do
    from alternatives in query,
      group_by: alternatives.id,
      left_join: answers in assoc(alternatives, :answers),
      select: {alternatives, count(answers.id)}
  end
end
