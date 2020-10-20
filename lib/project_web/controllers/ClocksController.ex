defmodule ProjectWeb.ClocksController do
  use ProjectWeb, :controller
def getById(conn, %{"clocksID" => clocksID}) do
    try do
      clock = Repo.get!(Clocks, clocks)
      conn
      |> put_status(200) #requête avec succès  
      |> json(%{"id" => clock.id, "status" => clock.status, "time" => clock.time})
    rescue
      Ecto.NoResultsError -> json(conn, 400)#requête avec echec 
    end
  end
end
