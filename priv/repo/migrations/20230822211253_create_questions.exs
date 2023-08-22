defmodule Pento.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question_text, :string
      add :vote_count, :integer
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:author_id])
  end
end
