defmodule OpenStock.UserController do
  use OpenStock.Web, :controller
  alias OpenStock.User

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    json conn, user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    # Persist User into Database
  end
end