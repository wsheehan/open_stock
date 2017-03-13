defmodule OpenStock.Repo.Migrations.AddDescriptionToWatchlists do
  use Ecto.Migration

  def change do
    alter table(:watchlists) do
      add :description, :string
    end
  end
end
