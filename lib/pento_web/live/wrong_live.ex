defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        number: get_random_int(),
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2><%= @message %></h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    <h2>Guessed number: <%= @number %></h2>
    <pre>
      <%= @user.email %>
      <%= @session_id %>
    </pre>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {int_guess, ""} = Integer.parse(guess)

    {message, score, number} =
      if socket.assigns.number != int_guess do
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1
        {message, score, socket.assigns.number}
      else
        message = "Your guess: #{guess}. Correct!. "
        score = socket.assigns.score + 1
        {message, score, get_random_int()}
      end

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        number: number
      )
    }
  end

  defp get_random_int, do: Enum.random(1..10)
end
