defmodule Rumbl.CRoles.UserRole do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "user_roles" do
    belongs_to(:role, Rumbl.CRoles.Role, primary_key: true)
    belongs_to(:user, Rumbl.Accounts.User, primary_key: true)

    timestamps()
  end

  def changeset(user_role, attrs \\ %{}) do
    user_role
    |> cast(attrs, [:role_id, :user_id])
    |> validate_required([:role_id, :user_id])

  end


end
