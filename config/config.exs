# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :ex_currency_live_view, ExCurrencyLiveViewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LgIpDpSnYAJcY8c9yJfnxu9nDlAp4il3Gpcn05VgT0Yf5ja42NESlmn74+dXRfqp",
  render_errors: [view: ExCurrencyLiveViewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExCurrencyLiveView.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "vOZyVDHnmSncuuzKP4CnL4XD3Qu92EMb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
