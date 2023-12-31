defmodule Pento.Survey.Demographic.Query do
  @moduledoc false

  import Ecto.Query
  alias Pento.Survey.Demographic

  def base, do: Demographic

  def for_user(query \\ base(), user) do
    where(query, [d], d.user_id == ^user.id)
  end
end
