import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

config :pento, Pento.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "pento_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :pento, PentoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "UkBip2rC2qk13c+OYEvRAGnf8v7TcIKXZ/Z0ik91j5jRYcMX33mt3dHj5fSA18za",
  server: false

config :pento, Pento.Mailer, adapter: Swoosh.Adapters.Test

config :swoosh, :api_client, false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
