defmodule S3AwsWeb.ImageController do
  use S3AwsWeb, :controller

  def create(conn, %{"image" => image_base64}) do
    s3_url = S3Aws.AssetStore.upload_image(image_base64)
    
    conn
    |> put_status(201)
    |> json(%{"url" => s3_url})
  end
end