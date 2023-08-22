defmodule PentoWeb.AnswerLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pento.FAQFixtures

  @create_attrs %{answer_text: "some answer_text", vote_count: 42}
  @update_attrs %{answer_text: "some updated answer_text", vote_count: 43}
  @invalid_attrs %{answer_text: nil, vote_count: nil}

  defp create_answer(_) do
    answer = answer_fixture()
    %{answer: answer}
  end

  describe "Index" do
    setup [:create_answer]

    test "lists all answers", %{conn: conn, answer: answer} do
      {:ok, _index_live, html} = live(conn, ~p"/answers")

      assert html =~ "Listing Answers"
      assert html =~ answer.answer_text
    end

    test "saves new answer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/answers")

      assert index_live |> element("a", "New Answer") |> render_click() =~
               "New Answer"

      assert_patch(index_live, ~p"/answers/new")

      assert index_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#answer-form", answer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/answers")

      html = render(index_live)
      assert html =~ "Answer created successfully"
      assert html =~ "some answer_text"
    end

    test "updates answer in listing", %{conn: conn, answer: answer} do
      {:ok, index_live, _html} = live(conn, ~p"/answers")

      assert index_live |> element("#answers-#{answer.id} a", "Edit") |> render_click() =~
               "Edit Answer"

      assert_patch(index_live, ~p"/answers/#{answer}/edit")

      assert index_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#answer-form", answer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/answers")

      html = render(index_live)
      assert html =~ "Answer updated successfully"
      assert html =~ "some updated answer_text"
    end

    test "deletes answer in listing", %{conn: conn, answer: answer} do
      {:ok, index_live, _html} = live(conn, ~p"/answers")

      assert index_live |> element("#answers-#{answer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#answers-#{answer.id}")
    end
  end

  describe "Show" do
    setup [:create_answer]

    test "displays answer", %{conn: conn, answer: answer} do
      {:ok, _show_live, html} = live(conn, ~p"/answers/#{answer}")

      assert html =~ "Show Answer"
      assert html =~ answer.answer_text
    end

    test "updates answer within modal", %{conn: conn, answer: answer} do
      {:ok, show_live, _html} = live(conn, ~p"/answers/#{answer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Answer"

      assert_patch(show_live, ~p"/answers/#{answer}/show/edit")

      assert show_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#answer-form", answer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/answers/#{answer}")

      html = render(show_live)
      assert html =~ "Answer updated successfully"
      assert html =~ "some updated answer_text"
    end
  end
end
