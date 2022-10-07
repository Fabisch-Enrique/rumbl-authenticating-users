defmodule Rumbl.CRoles do

  import Ecto.Query, warn: false
  alias Rumbl.Repo

  alias Rumbl.CRoles.RolePermission
  alias Rumbl.CRoles.Permission
  alias Rumbl.CRoles.UserRole
  alias Rumbl.CRoles.Role

  #CRUDs for roles
  def list_all_roles do
    Repo.all(Role)
  end

  def get_role(id) do
    Repo.get(Role, id) |> Repo.preload(:role_permissions)
  end

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs \\ %{}) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  #CRUDs for permissions
  def list_all_permissions do
    Repo.all(Permission)
  end

  def get_permission(id) do
    Repo.get(Permission, id)
  end

  def create_permission(attrs \\ %{}) do
    %Permission{}
    |> Permission.changeset(attrs)
    |> Repo.insert()
  end

  def update_permission(%Permission{} = permission, attrs \\ %{}) do
    permission
    |> Permission.changeset(attrs)
    |> Repo.update()
  end

  def delete_permission(%Permission{} = permission) do
    Repo.delete(permission)
  end

  #CRUDs for role_permissions
  def list_role_permissions do
    Repo.all(RolePermission)
  end

  def get_role_permission(id) do
    Repo.get(RolePermission, id)
  end

  def create_role_permission(attrs  \\ %{}) do
    %RolePermission{}
    |> RolePermission.changeset(attrs)
    |> Repo.insert()
  end

  def update_role_permission(%RolePermission{} = role_permission, attrs \\ %{}) do
    role_permission
    |> RolePermission.changeset(attrs)
    |> Repo.update()
  end

  def delete_role_permission(%RolePermission{} = role_permission) do
    Repo.delete(role_permission)
  end

  #CRUDs for user roles
  def list_user_roles do
    Repo.all(UserRole)
  end

  def get_user_role(id) do
    Repo.get(UserRole, id)
  end
  def create_user_role(attrs \\ %{}) do
    %UserRole{}
    |> UserRole.changeset(attrs)
    |> Repo.insert()
  end
  def update_user_role(%UserRole{} = user_role, attrs \\ %{}) do
    user_role
    |> UserRole.changeset(attrs)
    |> Repo.update()
  end
  def delete_user_role(%UserRole{} = user_role) do
    Repo.delete(user_role)
  end

end
