defmodule OpenStock.Repo.Migrations.AddDescriptionToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :description, :string
    end
  end
end
