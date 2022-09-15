defmodule AppNameWeb.UserSettingsTwoFactorView do
  use AppNameWeb, :view

  def generate_qrcode(uri) do
    uri
    |> EQRCode.encode()
    |> EQRCode.svg(width: 264)
    |> Phoenix.HTML.raw()
  end
end
