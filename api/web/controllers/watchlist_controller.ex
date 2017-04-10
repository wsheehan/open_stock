defmodule OpenStock.WatchlistController do
  use OpenStock.Web, :controller

  alias OpenStock.Watchlist
  alias OpenStock.User
  alias OpenStock.Company

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
    query = from w in Watchlist,
      join: c in assoc(w, :companies),
      where: w.user_id == 11,
      preload: [:companies],
      select: map(w, [:title, :description, :id, companies: [:ticker, :name, :sector, :short_description]])

    watchlists = Repo.all(query)

    json conn, %{ watchlists: Repo.all(query) }
  end

  # def update(conn, params) do
  #   watchlist = Repo.get(Watchlist, id)
  #   changeset = Ecto.Changeset.change watchlist, params
  # end
end
