defmodule Pento.Survey.Rating.Query do
  @moduledoc false

  import Ecto.Query

  alias Pento.Survey.Rating

  def base, do: Rating

  def preload_user(user) do
    for_user(base(), user)
  end

  defp for_user(query, user) do
    where(query, [r], r.user_id == ^user.id)
  end
end
