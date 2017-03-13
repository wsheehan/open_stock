use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :open_stock, OpenStock.Endpoint,
  secret_key_base: "5r8smx3ZF0eZoIQ95NOA4fmCtJ0crv+V8Un1sA8bPyNpZ+PGKpYvTTvLORFDMx3E"

# Configure your database
config :open_stock, OpenStock.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "open_stock_prod",
  pool_size: 20
