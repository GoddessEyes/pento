defmodule PentoWeb.AnswerLive.Index do
  use PentoWeb, :live_view

  alias Pento.FAQ
  alias Pento.FAQ.Answer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :answers, FAQ.list_answers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Answer")
    |> assign(:answer, FAQ.get_answer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Answer")
    |> assign(:answer, %Answer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Answers")
    |> assign(:answer, nil)
  end

  @impl true
  def handle_info({PentoWeb.AnswerLive.FormComponent, {:saved, answer}}, socket) do
    {:noreply, stream_insert(socket, :answers, answer)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    answer = FAQ.get_answer!(id)
    {:ok, _} = FAQ.delete_answer(answer)

    {:noreply, stream_delete(socket, :answers, answer)}
  end
end
