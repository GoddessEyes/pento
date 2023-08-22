defmodule Pento.FAQTest do
  use Pento.DataCase

  alias Pento.FAQ

  describe "questions" do
    alias Pento.FAQ.Question

    import Pento.FAQFixtures

    @invalid_attrs %{question_text: nil, vote_count: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert FAQ.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert FAQ.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{question_text: "some question_text", vote_count: 42}

      assert {:ok, %Question{} = question} = FAQ.create_question(valid_attrs)
      assert question.question_text == "some question_text"
      assert question.vote_count == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FAQ.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{question_text: "some updated question_text", vote_count: 43}

      assert {:ok, %Question{} = question} = FAQ.update_question(question, update_attrs)
      assert question.question_text == "some updated question_text"
      assert question.vote_count == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = FAQ.update_question(question, @invalid_attrs)
      assert question == FAQ.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = FAQ.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> FAQ.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = FAQ.change_question(question)
    end
  end

  describe "answers" do
    alias Pento.FAQ.Answer

    import Pento.FAQFixtures

    @invalid_attrs %{answer_text: nil, vote_count: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert FAQ.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert FAQ.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{answer_text: "some answer_text", vote_count: 42}

      assert {:ok, %Answer{} = answer} = FAQ.create_answer(valid_attrs)
      assert answer.answer_text == "some answer_text"
      assert answer.vote_count == 42
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FAQ.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{answer_text: "some updated answer_text", vote_count: 43}

      assert {:ok, %Answer{} = answer} = FAQ.update_answer(answer, update_attrs)
      assert answer.answer_text == "some updated answer_text"
      assert answer.vote_count == 43
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = FAQ.update_answer(answer, @invalid_attrs)
      assert answer == FAQ.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = FAQ.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> FAQ.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = FAQ.change_answer(answer)
    end
  end
end
