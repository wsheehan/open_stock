defmodule OpenStock.Watchlist do
  use OpenStock.Web, :model

  schema "watchlists" do
    field :title, :string
    belongs_to :user, OpenStock.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
