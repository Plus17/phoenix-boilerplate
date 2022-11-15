defmodule AppNameWeb.Router do
  use AppNameWeb, :router

  import AppNameWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AppNameWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppNameWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppNameWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AppNameWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/users", AppNameWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    resources "/register", UserRegistrationController, only: [:new, :create]
    resources "/log_in", UserSessionController, only: [:new, :create]

    resources "/reset_password", UserResetPasswordController,
      only: [:new, :create, :edit, :update],
      param: "token"
  end

  scope "/users", AppNameWeb do
    pipe_through [:browser, :require_authenticated_user]

    resources "/settings", UserSettingsController, only: [:edit, :update], singleton: true

    get "/settings/confirm_email/:token", UserSettingsController, :confirm_email

    resources "/settings/two_factor_auth", UserSettingsTwoFactorController,
      only: [:new, :create, :delete],
      singleton: true

    get "/totp", UserTOTPController, :new
    post "/totp", UserTOTPController, :create
  end

  scope "/users", AppNameWeb do
    pipe_through [:browser]

    delete "/log_out", UserSessionController, :delete

    resources "/confirm", UserConfirmationController,
      only: [:new, :create, :edit, :update],
      param: "token"
  end

  live_session :admins, on_mount: {AppNameWeb.InitAssigns, :admin} do
    scope "/admin", AppNameWeb, as: :admin do
      pipe_through [:browser, :require_authenticated_user, :require_admin_user]

      live "/dashboard", Admin.DashboardLive
      live "/dashboard/users", Admin.UserLive
    end
  end

  scope "/health", log: false do
    forward "/", AppNameWeb.Plugs.HealthCheck
  end
end
