defmodule OpenStock.Repo.Migrations.CreateWatchlist do
  use Ecto.Migration

  def change do
    create table(:watchlists) do
      add :title, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:watchlists, [:user_id])

  end
end
