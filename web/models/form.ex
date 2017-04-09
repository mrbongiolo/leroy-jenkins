defmodule LeroyJenkins.Form do
  use LeroyJenkins.Web, :model

  schema "forms" do
    field :question, :string
    field :description, :string
    field :unique_cpf, :boolean
    field :unique_ip, :boolean

    has_many :alternatives, LeroyJenkins.Alternative
    has_many :answers, LeroyJenkins.Answer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :description, :unique_cpf, :unique_ip])
    |> validate_required([:question, :unique_cpf, :unique_ip])
  end
end
