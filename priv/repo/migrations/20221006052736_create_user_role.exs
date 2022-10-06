defmodule Rumbl.Repo.Migrations.CreateUserRole do
  use Ecto.Migration

  def change do
    create table(:user_roles, primary_key: false) do
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true, null: false)
      add(:role_id, references(:roles, on_delete: :delete_all), primary_key: true, null: false)

      timestamps()

    end
  end

end
