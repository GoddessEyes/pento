import Config

config :bcrypt_elixir, :log_rounds, 1

config :pento, Pento.Repo,
  username: "pento",
  password: "pento",
  hostname: "localhost",
  database: "pento_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :pento, PentoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "pQ2HPrjQSuSowPY1ZwNycA8VrETzIjjWdAA1xDWBr2WeRVio/0OfLUoZlB+3VP0F",
  server: false

config :pento, Pento.Mailer, adapter: Swoosh.Adapters.Test

config :swoosh, :api_client, false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
