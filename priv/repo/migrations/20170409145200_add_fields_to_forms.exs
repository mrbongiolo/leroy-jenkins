defmodule LeroyJenkins.Repo.Migrations.AddFieldsToForms do
  use Ecto.Migration

  def change do
    alter table(:forms) do
      add :unique_cpf, :boolean, default: false
      add :unique_ip, :boolean, default: false
    end
  end
end
