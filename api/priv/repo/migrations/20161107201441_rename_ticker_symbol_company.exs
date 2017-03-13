defmodule OpenStock.Repo.Migrations.RenameTickerSymbolCompany do
  use Ecto.Migration

  def change do
    rename table(:companies), :ticker_symbol, to: :ticker
  end
end
