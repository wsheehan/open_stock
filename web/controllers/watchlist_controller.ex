defmodule OpenStock.WatchlistController do
  use OpenStock.Web, :controller

  alias OpenStock.Watchlist
  alias OpenStock.User

  def create(conn, %{"watchlist" => watchlist_params}) do
    IO.puts "Hello"
    conn
    |> redirect(to: :index)
  end
end