defmodule S3Aws.AssetStore do
  alias ExAws.S3

  @spec upload_image(String.t) :: s3_url :: String.t

  def upload_image(image_base64) do
    image_bucket = "vilagenet"

    {:ok, image_binary} = Base.decode64(image_base64)

    filename =
      image_binary
      |> image_extension()
      |> unique_filename()

    {:ok, _response} =
      S3.put_object(image_bucket, filename, image_binary)
      |> ExAws.request()

    "https://#{image_bucket}.s3.amazonaws.com/#{filename}"
  end
  
  defp unique_filename(extension) do
    UUID.uuid4(:hex) <> extension
  end

  defp image_extension(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: ""
  defp image_extension(<<0xff, 0xD8, _::binary>>), do: ""
end