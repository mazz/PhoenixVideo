# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :virtu,
  ecto_repos: [Virtu.Repo]

# Configures the endpoint
config :virtu, VirtuWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GbSEhf07SRktI1IwWgCdR/0C5DxETFzVVV8tY1KrMz5PuOMplVVfkh8XyKO39WMi",
  render_errors: [view: VirtuWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Virtu.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
