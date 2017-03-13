defmodule OpenStock.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias OpenStock.Repo
  alias OpenStock.User

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end

  def sign_in(conn, email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && checkpw(password, user.encrypted_password) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw
        {:error, :not_found, conn}
    end
  end
end