defmodule ProjectWeb.WorkingTimesController do
  use ProjectWeb, :controller
  alias ProjectWeb.Repo
  alias ProjectWeb.Workingtimes

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
