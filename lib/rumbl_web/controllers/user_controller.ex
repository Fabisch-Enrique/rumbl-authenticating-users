defmodule RumblWeb.UserController do

  use RumblWeb, :controller
  plug :authenticate when action in [:index, :show]


  alias Rumbl.User


  def index(conn, _params) do

    case authenticate(conn) do
      %Plug.Conn{halted: true} = conn ->
        conn
      conn ->
        users = User.list()
        render conn, "index.html", users: users
    end

  end


  def show(conn, %{"id" => user_id}) do
    user = User.get(user_id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%Rumbl.User{}, %{})
    render(conn, "form.html", changeset: changeset)
  end



  def create(conn, %{"user" => user_params}) do
    case User.create(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.first_name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, changeset} ->
        render(conn, "form.html", changeset: changeset)

    end
  end


  def update(conn, %{"id" => user_id, "user" => user}) do

    case User.update(user_id, user) do
      {:ok, _topic} ->
        conn
        |> redirect(to: Routes.user_path(conn, :index))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "form.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => user_id}) do
    {:ok, _} = User.delete(user_id)
    conn
    |> redirect(to: Routes.user_path(conn, :index))
  end

#plugs
  defp authenticate(conn) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

end
