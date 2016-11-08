defmodule OpenStock.CompanyController do
  use OpenStock.Web, :controller
  alias OpenStock.Company

  def show(conn, %{"ticker" => ticker}) do
    query = from company in Company,
        where: company.ticker == ^ticker,
        select: company

    json conn, CallApi.match_query(query, ticker)
  end
end