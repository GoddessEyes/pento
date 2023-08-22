defmodule Pento.FAQ.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :answer_text, :string
    field :vote_count, :integer
    field :author_id, :id
    field :question_id, :id

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:answer_text, :vote_count])
    |> validate_required([:answer_text, :vote_count])
  end
end
