defmodule Rumbl.CRoles.Permission do
  use Ecto.Schema
  import Ecto.Changeset


  schema "permissions" do
    field :name, :string
    field :key, :string

    timestamps()
  end

  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :key])
    |> validate_required(:name)

  end


end
