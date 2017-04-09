defmodule LeroyJenkins.Repo.Migrations.CreateAnswer do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :name, :string
      add :address, :string
      add :cpf, :string
      add :suggestions, :text
      add :ip, :inet
      add :alternative_id, references(:alternatives, on_delete: :nothing)

      timestamps()
    end
    create index(:answers, [:alternative_id])

  end
end
