defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
