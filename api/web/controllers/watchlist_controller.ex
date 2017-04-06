defmodule OpenStock.WatchlistController do
  use OpenStock.Web, :controller

  alias OpenStock.Watchlist
  alias OpenStock.User

  # def action(conn, _) do
  #   apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  # end

  def create(conn, %{"watchlist" => watchlist_params}, current_user) do
    changeset = Watchlist.changeset(%Watchlist{}, watchlist_params)
    |> Ecto.Changeset.put_assoc(:user, current_user)
    Repo.insert!(changeset)
    conn
    |> redirect(to: "/users/#{current_user.id}")
  end

  def index(conn, _params) do
    # current_user_with_watchlists = Repo.preload(current_user, :watchlists)
    query = from w in Watchlist,
      where: w.user_id == 11,
      select: map(w, [:title, :description, :id])

    json conn, %{ watchlists: Repo.all(query) }
  end
end
