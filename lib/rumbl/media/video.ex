defmodule Rumbl.Media.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Rumbl.Media.Category

    timestamps()
  end

  #@required_fields ~w(url title description)
  #@optional_fields ~w(category_id)

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, [:url, :title, :description])
    |> assoc_constraint(:category)
  end

end
