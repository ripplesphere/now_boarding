# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_station,
  ecto_repos: [ElixirStation.Repo]

# Configures the endpoint
config :elixir_station, ElixirStation.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZLDN2KuCWHeLaUIL6sC2UM34FAwXKCpFzmZfBbYOC2AsnmfRTYYQ5Z1bwBjU90gn",
  render_errors: [view: ElixirStation.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirStation.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
