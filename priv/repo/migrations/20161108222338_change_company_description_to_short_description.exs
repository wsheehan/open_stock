defmodule OpenStock.Repo.Migrations.ChangeCompanyDescriptionToShortDescription do
  use Ecto.Migration

  def change do
    rename table(:companies), :description, to: :short_description
  end
end
