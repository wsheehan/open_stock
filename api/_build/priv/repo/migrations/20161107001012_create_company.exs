defmodule OpenStock.Repo.Migrations.CreateCompany do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :ticker_symbol, :string
      add :name, :string

      timestamps()
    end

  end
end
