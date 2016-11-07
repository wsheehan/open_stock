defmodule OpenStock.Repo.Migrations.AddSectorToCompanies do
  use Ecto.Migration

  def change do
    alter_table(:companies) do
      add :sector, :string
    end
  end
end
