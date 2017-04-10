defmodule LeroyJenkins.Session do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :password, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_password
  end

  defp validate_password(%{valid?: true} = changeset) do
    if get_field(changeset, :password) == "123123123" do
      changeset
    else
      add_error(changeset, :password, "WRONG!!")
    end
  end
  defp validate_password(changeset), do: changeset
end
