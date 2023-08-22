defmodule Pento.FAQ.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field(:question_text, :string)
    field(:vote_count, :integer)
    field(:author_id, :id)

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question_text, :vote_count])
    |> validate_required([:question_text, :vote_count])
  end
end
