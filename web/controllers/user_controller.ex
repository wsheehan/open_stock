defmodule OpenStock.UserController do
  use OpenStock.Web, :controller

  alias OpenStock.User
  alias OpenStock.Company
  alias OpenStock.Auth

  plug :scrub_params, "user" when action in [:create]

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    companies = Repo.all(Company)
    render conn, "show.html", user: user, companies: companies
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = %User{} |> User.register_changeset(user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "#{user.email} created")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        conn
        render(conn, "new.html", changeset: changeset)
    end
  end
end