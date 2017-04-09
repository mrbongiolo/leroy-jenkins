defmodule LeroyJenkins.Answer do
  use LeroyJenkins.Web, :model

  schema "answers" do
    field :name, :string
    field :address, :string
    field :cpf, :string
    field :suggestions, :string
    field :ip, EctoNetwork.INET

    belongs_to :alternative, LeroyJenkins.Alternative

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :cpf, :suggestions, :ip])
    |> validate_required([:cpf, :ip])
    |> validate_format(:cpf, ~r/\d{3}\.\d{3}\.\d{3}-\d{2}/)
    |> assoc_constraint(:alternative)
  end
end
