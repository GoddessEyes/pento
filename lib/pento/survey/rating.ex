defmodule Pento.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :start, :integer
    field :user_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:start])
    |> validate_required([:start])
  end
end
