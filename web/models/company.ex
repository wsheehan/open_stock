defmodule OpenStock.Company do
  use OpenStock.Web, :model

  schema "companies" do
    field :ticker_symbol, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ticker_symbol, :name])
    |> validate_required([:ticker_symbol, :name])
  end
end
