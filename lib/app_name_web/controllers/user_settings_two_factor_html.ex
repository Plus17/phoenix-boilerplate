defmodule AppNameWeb.UserSettingsTwoFactorHTML do
  use AppNameWeb, :html

  embed_templates "user_settings_two_factor_html/*"

  def generate_qrcode(uri) do
    uri
    |> EQRCode.encode()
    |> EQRCode.svg(width: 264)
    |> Phoenix.HTML.raw()
  end
end
