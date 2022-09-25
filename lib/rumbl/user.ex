defmodule Rumbl.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rumbl.Repo


  schema "users" do
    field :first_name, :string
    field :second_name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()

  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :second_name, :email])
    |> validate_length(:first_name, min: 3, max: 10)
    |> validate_length(:second_name, min: 5, max: 15)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> put_pass_hash()

  end

  defp put_pass_hash(changeset) do

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
          _ ->
            changeset
    end
  end


  def list do
    Repo.all(__MODULE__)
  end

  def create(attrs) do
    changeset(%__MODULE__{}, attrs) |> Repo.insert()
  end


  def update(id, attrs) do
    get(id) |> changeset(attrs) |> Repo.update()
  end

  def get(id) do
    Repo.get!(__MODULE__, id)
  end

end
