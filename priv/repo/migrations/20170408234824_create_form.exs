defmodule LeroyJenkins.Repo.Migrations.CreateForm do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :question, :text
      add :description, :text

      timestamps()
    end

  end
end
