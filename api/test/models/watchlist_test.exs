defmodule OpenStock.WatchlistTest do
  use OpenStock.ModelCase

  alias OpenStock.Watchlist

  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Watchlist.changeset(%Watchlist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Watchlist.changeset(%Watchlist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
