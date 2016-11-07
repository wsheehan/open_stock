defmodule OpenStock.Company do
  use OpenStock.Web, :model

  schema "companies" do
    field :ticker, :string
    field :name, :string
    field :sector, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ticker, :name, :sector, :description])
    |> validate_required([:ticker, :name, :sector, :description])
  end
end
