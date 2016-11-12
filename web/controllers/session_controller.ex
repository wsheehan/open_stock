defmodule OpenStock.SessionController do
  use OpenStock.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    # login user
  end

  def delete(conn, _) do
    # logout user
  end
end