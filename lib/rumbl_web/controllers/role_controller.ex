defmodule RumblWeb.RoleController do

  use RumblWeb, :controller

  alias Rumbl.CRoles

  def index(conn, _param) do
    roles = CRoles.list_all_roles
    render(conn, "index.html", roles: roles)
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



end
