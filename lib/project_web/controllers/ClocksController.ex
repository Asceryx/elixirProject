defmodule ProjectWeb.ClocksController do
  use ProjectWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
