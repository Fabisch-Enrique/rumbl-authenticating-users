defmodule Rumbl.Repo.Migrations.CreateRolePermissions do
  use Ecto.Migration

  def change do
    create table(:roles_permissions, primary_key: false) do
      add(:permission_id, references(:permissions, on_delete: :delete_all), primary_key: true, null: false)
      add(:role_id, references(:roles, on_delete: :delete_all), primary_key: true, null: false)

      timestamps()

    end
  end

end
