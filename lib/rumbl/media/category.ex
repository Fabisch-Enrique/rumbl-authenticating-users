defmodule Rumbl.Media.Category do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    has_many :videos, Rumbl.Media.Video


    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end

  def names_and_ids(query)  do
    from c in query, select: {c.name, c.id}
  end

end
