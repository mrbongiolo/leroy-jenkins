# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :leroy_jenkins,
  ecto_repos: [LeroyJenkins.Repo]

# Configures the endpoint
config :leroy_jenkins, LeroyJenkins.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RSkaeFWf3Z2svuAlDiUkP4AYaMwtN4P/gEfGsActYYXhJy43LHcsfrTNg8G5r0Li",
  render_errors: [view: LeroyJenkins.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LeroyJenkins.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use SLIM as template
config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
