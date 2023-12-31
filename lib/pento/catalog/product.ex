defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Survey.Rating

  schema "products" do
    field(:name, :string)
    field(:description, :string)
    field(:unit_price, :float)
    field(:sku, :integer)
    field(:image_upload, :string)
    has_many(:ratings, Rating)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
  end
end
