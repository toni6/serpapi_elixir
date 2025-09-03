import Config

config :pythonx, :uv_init,
  pyproject_toml: """
  [project]
  name = "serp_elixir"
  version = "0.1.0"
  requires-python = "==3.13.*"
  dependencies = [
    "serpapi>=0.1.5"
  ]
  """

config :serp_elixir, :api_key, System.get_env("SERPAPI_KEY")
