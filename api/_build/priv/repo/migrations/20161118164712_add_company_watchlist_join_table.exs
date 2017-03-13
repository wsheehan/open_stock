defmodule OpenStock.Repo.Migrations.AddCompanyWatchlistJoinTable do
  use Ecto.Migration

  def change do
    create table(:companies_watchlists, primary_key: false) do
      add :watchlist_id, references(:watchlists)
      add :companies, references(:companies)
    end
  end
end
