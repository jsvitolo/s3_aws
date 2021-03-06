# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :s3_aws,
  ecto_repos: [S3Aws.Repo]

config :ex_aws,
  access_key_id: [System.get_env("AWS_ACCESS_KEY_ID"), :instance_role],
  secret_access_key: [System.get_env("AWS_SECRET_ACCESS_KEY"), :instance_role],
  s3: [
    scheme: "https://",
    host: "#{System.get_env("BUCKET_NAME")}.s3.amazonaws.com",
    region: "sa-east-1"
  ],
  bucket_name: "#{System.get_env("BUCKET_NAME")}"

# Configures the endpoint
config :s3_aws, S3AwsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XbUcz2gyi1+wTRvWq4niA6+OMCzVVZ9+aIH0qbErv8j4SqtsOFRSSwYHqOxzLcVc",
  render_errors: [view: S3AwsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: S3Aws.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
