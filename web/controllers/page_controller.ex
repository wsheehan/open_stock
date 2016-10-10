defmodule OpenStock.PageController do
  use OpenStock.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
