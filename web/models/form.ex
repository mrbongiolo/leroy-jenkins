defmodule LeroyJenkins.Form do
  use LeroyJenkins.Web, :model

  schema "forms" do
    field :question, :string
    field :description, :string

    has_many :alternatives, LeroyJenkins.Alternative

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :description])
    |> validate_required([:question])
  end
end
