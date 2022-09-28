defmodule RumblWeb.VideoController do
  use RumblWeb, :controller

  alias Rumbl.Repo
  #alias Rumbl.Media
  alias Rumbl.Media.Video

#custom action function for video_controller which ggives/shows a link between videos & users
#since all actions are dependent on the current user, we will first add [user] as an argument
#we call this function on our actions ~> "create" and "new" such that it grabs the current user and scopes the user against the current operation
  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

#custom function to look up all videos for a user
# we will call this function on our actions ~> "index" and "show" to show us videos/a video associated with a specified user
  defp user_videos(user) do
    Ecto.assoc(user, :videos)
  end

  def index(conn, _params, user) do
    videos = Repo.all(user_videos(user))
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> Ecto.build_assoc(:videos)
      |> Video.changeset(%{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, user) do
    changeset =
      user
      |> Ecto.build_assoc(:videos)
      |> Video.changeset(video_params)

    case Repo.insert(changeset) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    video = Repo.get(user_videos(user), id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}, user) do
    video = Repo.get(user_videos(user), id)
    changeset =
      user
      |> Ecto.build_assoc(:videos)
      |> Video.changeset(Map.take(video, [:url, :title, :description]))

    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, user) do
    video = Repo.get(user_videos(user), id)

    case Repo.update(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    video = Repo.get(user_videos(user), id)
    {:ok, _video} = Repo.delete(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end
end
