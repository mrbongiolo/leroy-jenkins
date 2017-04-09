defmodule LeroyJenkins.Repo.Migrations.AddFormIdToAnswers do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      add :form_id, references(:forms, on_delete: :nothing)
    end
    create index(:answers, [:form_id])

  end
end
