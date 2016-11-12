defmodule OpenStock.Watchlist do
  use OpenStock.Web, :model

  schema "watchlists" do
    field :title, :string
    belongs_to :user, OpenStock.User

    timestamps()
  end

  @required_fields ~w(title)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
  end
end