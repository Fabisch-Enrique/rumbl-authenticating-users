defmodule RumblWeb.UserController do
  use RumblWeb, :controller


  alias Rumbl.User
  alias Rumbl.Repo

  def index(conn, _params) do
    users = User.list()
    render conn, "index.html", users: users

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
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
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

end
