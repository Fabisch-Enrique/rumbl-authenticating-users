alias Rumbl.Repo
alias Rumbl.CRoles.Permission
alias Rumbl.Media.Category

for category <- ~w(Action Drama Romance Comedy Sci Fi) do
  Repo.get_by!(Category, name: category) ||
  Repo.insert!(%Category{name: category})
end

for permission <- ~w(ManageUser ViewUser ViewVideos  CreateVideos EditVideos DeleteVideos) do
  Repo.get_by!(Permission, name: permission) ||
  Repo.insert!(%Permission,{name: permission})
end


# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
