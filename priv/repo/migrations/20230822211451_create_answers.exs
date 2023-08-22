defmodule Pento.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :answer_text, :string
      add :vote_count, :integer
      add :author_id, references(:users, on_delete: :nothing)
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:author_id])
    create index(:answers, [:question_id])
  end
end
