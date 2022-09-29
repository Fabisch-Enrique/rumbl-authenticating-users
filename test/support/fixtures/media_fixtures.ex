defmodule Rumbl.MediaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rumbl.Media` context.
  """

  @doc """
  Generate a video.
  """
  def video_fixture(attrs \\ %{}) do
    {:ok, video} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        url: "some url"
      })
      |> Rumbl.Media.create_video()

    video
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Rumbl.Media.create_category()

    category
  end
end
