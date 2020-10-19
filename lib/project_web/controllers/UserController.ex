defmodule ProjectWeb.UserController do
  use ProjectWeb, :controller
  alias Project.Repo
  alias Project.Users

  def getById(conn, %{"userID" => userID}) do
    try do
      user = Repo.get!(Users, userID)
      json(conn, %{user: user})
    rescue
      Ecto.NoResultsError -> json(conn, 400)
    end
  end

  def add(conn, params) do
    json(conn, %{body: params})
  end

  def edit(conn, params) do
    json(conn, %{body: params})
  end

  def delete(conn, params) do
    json(conn, %{body: params})
  end
end
