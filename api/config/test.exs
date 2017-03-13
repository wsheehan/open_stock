use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :open_stock, OpenStock.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :open_stock, OpenStock.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "open_stock_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
