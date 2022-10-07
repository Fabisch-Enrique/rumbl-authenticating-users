defmodule RumblWeb.PermissionController do

  use RumblWeb, :controller

  alias Rumbl.CRoles
  alias Rumbl.CRoles.Permission

  
  def index(conn, _params) do
    permission = CRoles.list_all_permissions
    render(conn, "index.html", permission: permission)
  end

  def new(conn, _params) do
    changeset = Permission.changeset(%Permission{}, %{})
    render(conn, "form.html", changeset: changeset)
  end

  def show(conn, %{"id" => permission_id}) do
    permission = CRoles.get_permission(permission_id)
    render(conn, "show.html", permission: permission)
  end

  def create(conn, %{"permission" => permission_params}) do
    case CRoles.create_permission(permission_params) do
      {:ok, permission} ->
        conn
        |> put_flash(:info, "#{permission.name} created!")
        |> redirect(to: Routes.permission_path(conn, :index))
      {:error, changeset} ->
        render(conn, "form.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => permission_id}) do

    case CRoles.update_permission(permission_id) do
      {:ok, _role} ->
        conn
        |> redirect(to: Routes.permission_path(conn, :index))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "form.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => permission_id}) do
    permission = CRoles.get_permission(permission_id)
    {:ok, _} = CRoles.delete_permission(permission)
    conn
    |> redirect(to: Routes.permission_path(conn, :index))
  end

end
