defmodule Mix.Tasks.OpenStock.ImportCompanies do
  use Mix.Task

  @shortdoc "Import Stocks from S&P 500 from CSV file"

  def run(_args) do
    File.stream!("/Users/willsheehan/Desktop/sp_companies.csv") |>
    CSV.decode(separator: ?\t) |>
    Enum.map(fn row ->
      stock_row = Enum.at(row, 0) |> String.split(",")
      IO.puts Enum.at(stock_row, 0)
    end)
  end
end