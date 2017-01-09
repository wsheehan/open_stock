defmodule OpenStock.WatchlistController do
  use OpenStock.Web, :controller

  alias OpenStock.Watchlist
  alias OpenStock.User

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def create(conn, %{"watchlist" => watchlist_params}, current_user) do
    changeset = Watchlist.changeset(%Watchlist{}, watchlist_params)
    |> Ecto.Changeset.put_assoc(:user, current_user)
    Repo.insert!(changeset)
    conn
    |> redirect(to: "/users/#{current_user.id}")
  end

  def index(conn, _params, current_user) do
    current_user_with_watchlists = Repo.preload(current_user, :watchlists)
    render conn, "index.html", watchlists: current_user_with_watchlists.watchlists
  end
end
