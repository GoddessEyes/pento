defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
      <.link href="#" phx-click="guess" phx-value-number= {n} >
        <%= n %>
      </.link>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def mount(_params, session, socket) do
    user = Pento.Accounts.get_user_by_session_token(session["user_token"])

    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Make a guess:",
        time: time(),
        session_id: session["live_socket_id"],
        current_user: user
      )
    }
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time()
      )
    }
  end
end
