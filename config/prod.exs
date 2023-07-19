import Config

config :pento, PentoWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Pento.Finch

config :logger, level: :info
