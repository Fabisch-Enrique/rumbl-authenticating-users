defmodule Rumbl.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :second_name, :string, null: false
      add :email, :string
      add :password, :string
      add :password_hash, :string

      timestamps()

    end
    create unique_index(:users, [:email])
  end
  
end
