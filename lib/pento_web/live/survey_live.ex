defmodule PentoWeb.SurveyLive do
  @moduledoc false
  use PentoWeb, :live_view

  alias Pento.Survey

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_demographic()}
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(demographic, socket)}
  end

  def handle_demographic_created(demographic, socket) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end
end
