defmodule RumblWeb.RoleController do

  use RumblWeb, :controller

  alias Rumbl.CRoles
  alias Rumbl.CRoles.Role

  def index(conn, _param) do
    roles = CRoles.list_all_roles
    render(conn, "index.html", roles: roles)
  end

  def new(conn, _params) do
    changeset = Role.changeset(%Role{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => role_id}) do
    role = CRoles.get_role(role_id)
    render(conn, "show.html", role: role)
  end

  def edit(conn, %{"id" => role_id}) do
    role = CRoles.get_role(role_id)
    changeset =
      role
      |> Role.changeset(Map.take(role, [:name]))

    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    case CRoles.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "#{role.name} created!")
        |> redirect(to: Routes.role_path(conn, :index))

      {:error, changeset} ->
        render(conn, "form.html", changeset: changeset)
    end
  end

  def update(conn, %{"role" => role_id}) do

    case CRoles.update_permission(role_id) do
      {:ok, _role} ->
        conn
        |> redirect(to: Routes.role_path(conn, :index))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "form.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => role_id}) do
    role = CRoles.get_role(role_id)
    {:ok, _} = CRoles.delete_role(role)
    conn
    |> redirect(to: Routes.role_path(conn, :index))
  end



end
