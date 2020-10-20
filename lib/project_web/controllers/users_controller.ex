defmodule ProjectWeb.UsersController do
  use ProjectWeb, :controller

  alias Project.Account
  alias Project.Account.Users

  action_fallback ProjectWeb.FallbackController

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- Account.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> json(200)
    end
  end

  def show(conn, %{"userID" => userID}) do
    users = Account.get_users!(userID)
    conn
    |> json(%{"id" => users.id, "username" => users.username, "email" => users.email})
  end

  def showByUsername(conn, %{ "username" => username, "email" => email}) do
    users = Account.get_users_by_username!(username, email)
    conn
    |> json(%{"id" => users.id, "username" => users.username, "email" => users.email})
  end

  def update(conn, %{"userID" => userId, "users" => users_params}) do
    users = Account.get_users!(userId)

    with {:ok, %Users{} = users} <- Account.update_users(users, users_params) do
      conn
      |> put_status(201)
      |> put_resp_header("location", Routes.users_path(conn, :update, users))
      |> json("Updated")
    end
  end

  def delete(conn, %{"userID" => id}) do
    users = Account.get_users!(id)

    with {:ok, %Users{}} <- Account.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
