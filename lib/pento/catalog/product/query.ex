defmodule Pento.Catalog.Product.Query do
  @moduledoc false

  import Ecto.Query
  alias Pento.Catalog.Product
  alias Pento.Survey.Rating

  def base, do: Product

  def with_user_ratings(user) do
    preload_user_ratings(base(), user)
  end

  def preload_user_ratings(query, user) do
    ratings_query = Rating.Query.preload_user(user)

    preload(query, ratings: ^ratings_query)
  end
end
