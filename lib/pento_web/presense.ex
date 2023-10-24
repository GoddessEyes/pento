defmodule PentoWeb.Presense do
  use Phoenix.Presence,
    otp_app: :pento,
    pubsub_server: Pento.PubSub

  @user_activity_topic "user_activity"

  def track_user(pid, product, user_email) do
    track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: user_email}]}
    )
  end
end
