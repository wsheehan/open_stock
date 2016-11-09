defmodule OpenStock.User do
  use OpenStock.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    has_many :watchlists, OpenStock.Watchlist

    timestamps()
  end

  @required_fields ~w(email)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
