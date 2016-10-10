# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :open_stock,
  ecto_repos: [OpenStock.Repo]

# Configures the endpoint
config :open_stock, OpenStock.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fFIMtZfGgCBljxRd+D5CaWHIn7jRK72w3MOuWgIdMnv6v9fZQ5zLF1kOPwo5mGQc",
  render_errors: [view: OpenStock.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OpenStock.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
