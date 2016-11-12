defmodule OpenStock.SessionController do
  use OpenStock.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  alias OpenStock.User

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    user = Repo.get_by(User, email: email)
    IO.puts user.encrypted_password
    authenticated = cond do
      user && checkpw(password, user.encrypted_password) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw
        {:error, :not_found, conn}
    end

    case authenticated do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You're now logged in")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    # logout user
  end

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end
end