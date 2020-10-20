defmodule ProjectWeb.WorkingtimeController do
  use ProjectWeb, :controller

  alias Project.ElixirProject
  alias Project.ElixirProject.Workingtime

  action_fallback ProjectWeb.FallbackController

  def index(conn, _params) do
    workingtimes = ElixirProject.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => user_id, "start" => start, "end" => endi}) do
    with {:ok, %Workingtime{}} <- ElixirProject.create_workingtime(%{"id_user"=> user_id, "start"=> start, "end"=> endi} ) do
      conn
      |> json(200)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = ElixirProject.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def getById(conn, %{"userID" => user_id, "workingtimeID" => workingtime_id}) do
    workingtime = ElixirProject.get_workingtime_by_user(user_id,  workingtime_id)
    json(conn, workingtime)
  end

  def getAll(conn, %{"userID" => user_id, "start" => start_time, "end" => end_time}) do
    workingtime = ElixirProject.get_workingtime_by_intervall(user_id,  start_time, end_time)
    json(conn, workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = ElixirProject.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- ElixirProject.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = ElixirProject.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- ElixirProject.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
