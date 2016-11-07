defmodule CallApi do
  use HTTPoison.Base
  alias OpenStock.Company
  alias OpenStock.Repo

  @expected_fields ~w(
    ticker short_description sector
    name mailing_address
  )

  def get_api(url) do
    hackney = [ hackney: [basic_auth: {"eada4ad55493b61365859339c4c383d3", "4de15d2c4757c9eb733300e8c3691c36"}]]
    HTTPoison.get("https://www.intrinio.com/api/" <> url, [], hackney) |> get_response()
  end

  def parse_body(body) do
    body
      |> Poison.decode!
      |> Map.take(@expected_fields)
  end

  def get_response(request) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = request
    case body do
      "" ->
        "Company Not Found"
      _->
        parse_body(body)
    end
  end

  def check_response(params, ticker) do
    case params do
      "Company Not Found" ->
        %{error: "Company Not Found"}
      _->
        changeset = Company.changeset(%Company{}, params)
        Repo.insert(changeset)
        %Company{ sector: sector, name: name} = Repo.get_by(Company, ticker_symbol: ticker)
        %{ticker_symbol: ticker, sector: sector, name: name}
    end
  end

  def match_query(query, ticker) do
    cond do
      Repo.all(query) == [] ->
        params = get_api("companies?ticker=" <> ticker)
        check_response(params, ticker)
      true ->
        %Company{ sector: sector, name: name } = Repo.get_by(Company, ticker_symbol: ticker)
        %{ticker_symbol: ticker, sector: sector, name: name}
    end
  end
end