defmodule RumblWeb.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn

  #imports for our put_flash and redirect
  import Phoenix.Controller
  alias RumblWeb.Router.Helpers, as: Routes

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

    @doc """

    Check if there is a user in the seeions and store it in conn.assigns for every incoming request
    The conn.assigns can be accessed from controllers and views

    """

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Rumbl.Accounts.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

    @doc """

    Checks whether there is a user associated with the email given
        1. if there is an existing user,
            a. compares the hashes and signs them in
            b. else returns an error if the hashes dont match
    """

  def login_by_email_and_pswd(conn, email, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Rumbl.Accounts.User, email: email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end

  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  # we also want to restrict the video actions to LOGGED-IN-USERS
  def authenticate_user(conn, _opts) do
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
