defmodule S3AwsWeb.PageController do
  use S3AwsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
