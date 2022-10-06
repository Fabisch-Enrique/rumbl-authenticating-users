defmodule Rumbl.CRoles.Role do
  use Ecto.Schema
  import Ecto.Changeset


  schema "roles" do
    field :name, :string

    timestamps()
  end

  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:name])
    |> validate_required(:name)

  end


end
