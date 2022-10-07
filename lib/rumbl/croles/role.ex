defmodule Rumbl.CRoles.Role do
  use Ecto.Schema
  import Ecto.Changeset


  schema "roles" do
    field :name, :string
    has_many(:role_permissions, Rumbl.CRoles.RolePermission, on_replace: :delete)
    timestamps()
  end

  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name)
    |> cast_assoc(:role_permissions)



  end


end
