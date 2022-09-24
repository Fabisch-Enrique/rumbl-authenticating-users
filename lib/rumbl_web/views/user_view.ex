defmodule RumblWeb.UserView do
  use RumblWeb, :view
  alias Rumbl.User

def first_name(%User{first_name: first_name}) do
  first_name
  |> String.split(" ")
  |> Enum.at(0)
end

end
