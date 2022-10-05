defmodule RumblWeb.SessionController do

  use RumblWeb, :controller

  alias Rumbl.User

  def new(conn, _) do
    if conn.assigns.current_user do
      redirect(conn, to: Routes.page_path(conn, :index))
    else
      render(conn, "new.html")

    end
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pswd}}) do

    case RumblWeb.Auth.login_by_email_and_pswd(conn, email, pswd, repo: Rumbl.Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome Back!!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid Email or Password")
        |> render("new.html")
    end
  end

   def rregister(conn, _params) do
    changeset = User.changeset(%Rumbl.User{}, %{})
    render(conn, "register.html", changeset: changeset)
  end

  def register(conn, %{"user" => user_params}) do
    case User.register(user_params) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "#{user.first_name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, changeset} ->
        render(conn, "register.html", changeset: changeset)

    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
