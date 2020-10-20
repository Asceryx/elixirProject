defmodule ProjectWeb.UserController do
  use ProjectWeb, :controller
  alias Project.Repo
  alias Project.Users

  def getById(conn, %{"userID" => userID}) do
    try do
      user = Repo.get!(Users, userID)
      conn
      |> put_status(200)
      |> json(%{"id" => user.id, "username" => user.username, "email" => user.email})
    rescue
      Ecto.NoResultsError -> json(conn, 400)
    end
  end

  def add(conn, %{"email" => email, "username" => username}) do
    changeset =
      Users.changeset(%Users{}, %{"email" => email, "username" => username})

    case Repo.insert!(changeset) do
      {:ok, _user} ->
        json(conn |> put_status(:created), %{success: "User created"})

      {:error, changeset} ->
        json(conn, 400)
    end

    conn
    |> put_status(201)
    |> json(%{"response" => "create"})
  end

  def edit(conn, %{"id" => id, "email" => email, "username" => username}) do
    user = Repo.get(Users, id)

    changeset = 
      Users.changeset(%Users{}, %{"email" => email, "username" => username})
    |> change(%{ username: "New title" })
    
    json(conn, 200)
    # case Repo.insert!(changeset) do
    #   {:ok, _user} ->
    #     json(conn |> put_status(:created), %{success: "User created"})

    #   {:error, changeset} ->
    #     json(conn, 400)
    # end

    # conn
    # |> put_status(201)
    # |> json(%{"response" => "create"})
  end

  def delete(conn, params) do
    json(conn, %{body: params})
  end
end
