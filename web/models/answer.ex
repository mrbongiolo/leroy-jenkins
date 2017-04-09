defmodule LeroyJenkins.Answer do
  use LeroyJenkins.Web, :model

  alias LeroyJenkins.Repo

  schema "answers" do
    field :name, :string
    field :address, :string
    field :cpf, :string
    field :suggestions, :string
    field :ip, EctoNetwork.INET

    belongs_to :form, LeroyJenkins.Form
    belongs_to :alternative, LeroyJenkins.Alternative

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:form_id, :alternative_id, :name, :address, :cpf, :suggestions, :ip])
    |> assoc_constraint(:form)
    |> assoc_constraint(:alternative)
    |> validate_required([:cpf, :ip])
    |> validate_format(:cpf, ~r/\d{3}\.\d{3}\.\d{3}-\d{2}/)
    |> validate_form_enforced_rules
  end

  defp validate_form_enforced_rules(%{valid?: true} = changeset) do
    form = Repo.get(LeroyJenkins.Form, get_field(changeset, :form_id))

    changeset
    |> validate_unique_field(form, :cpf, form.unique_cpf)
    |> validate_unique_field(form, :ip, form.unique_ip)
  end
  defp validate_form_enforced_rules(changeset), do: changeset

  defp validate_unique_field(changeset, form, field, enforce_unique?) when enforce_unique? do
    answer = Repo.get_by(LeroyJenkins.Answer,
      form_id: form.id,
      "#{field}": get_field(changeset, field))

    if answer do
      add_error(changeset, field, "deve ser único")
    else
      changeset
    end
  end
  defp validate_unique_field(changeset, _, _, _), do: changeset
end
