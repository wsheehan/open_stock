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
    request = HTTPoison.get("https://www.intrinio.com/api/" <> url, [], hackney)
    response = get_response(request)
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
        %Company{ short_description: description, sector: sector, name: name, mailing_address: mailing_address } = Repo.get_by(Company, ticker: ticker)
        %{ticker: ticker, description: description, sector: sector, name: name, mailing_address: mailing_address}
    end
  end

  def match_query(query, ticker) do
    cond do
      Repo.all(query) == [] ->
        IO.puts "No Record Matching"
        params = get_api("companies?ticker=" <> ticker)
        check_response(params, ticker)
      true ->
        IO.puts "Record Matching"
        %Company{ short_description: description, sector: sector, name: name, mailing_address: mailing_address } = Repo.get_by(Company, ticker: ticker)
        %{ticker: ticker, description: description, sector: sector, name: name, mailing_address: mailing_address}
    end
  end
end