defmodule PentoWeb.AnswerLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.FAQ

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage answer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="answer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:answer_text]} type="text" label="Answer text" />
        <.input field={@form[:vote_count]} type="number" label="Vote count" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Answer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{answer: answer} = assigns, socket) do
    changeset = FAQ.change_answer(answer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"answer" => answer_params}, socket) do
    changeset =
      socket.assigns.answer
      |> FAQ.change_answer(answer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"answer" => answer_params}, socket) do
    save_answer(socket, socket.assigns.action, answer_params)
  end

  defp save_answer(socket, :edit, answer_params) do
    case FAQ.update_answer(socket.assigns.answer, answer_params) do
      {:ok, answer} ->
        notify_parent({:saved, answer})

        {:noreply,
         socket
         |> put_flash(:info, "Answer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_answer(socket, :new, answer_params) do
    case FAQ.create_answer(answer_params) do
      {:ok, answer} ->
        notify_parent({:saved, answer})

        {:noreply,
         socket
         |> put_flash(:info, "Answer created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
