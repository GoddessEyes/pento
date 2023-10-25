defmodule PentoWeb.Admin.UserActivityLive do
  use PentoWeb, :live_component

  def update(_assigns, socket) do
    {:ok, socket |> assign_user_activity()}
  end

  def assign_user_activity(socket) do
    assign(socket, :user_activity, PentoWeb.Presense.list_products_and_users())
  end
end
