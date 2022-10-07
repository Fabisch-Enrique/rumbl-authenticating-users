defmodule Rumbl.CRoles.RolePermission do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "roles_permissions" do
    belongs_to(:role, Rumbl.CRoles.Role, primary_key: true)
    belongs_to(:permission, Rumbl.CRoles.Permission, primary_key: true)

    timestamps()
  end

  def changeset(role_permission, attrs \\ %{}) do
    role_permission
    |> cast(attrs, [:role_id, :permission_id])

  end


end
