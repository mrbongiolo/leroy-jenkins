defmodule LeroyJenkins.Repo.Migrations.CreateAlternative do
  use Ecto.Migration

  def change do
    create table(:alternatives) do
      add :body, :text
      add :form_id, references(:forms, on_delete: :nothing)

      timestamps()
    end
    create index(:alternatives, [:form_id])

  end
end
