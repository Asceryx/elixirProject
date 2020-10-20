defmodule ProjectWeb.ExampleControllerTest do
  use ProjectWeb.ConnCase

  alias Project.Test
  alias Project.Test.Example

  @create_attrs %{
    email: "some email",
    username: "some username"
  }
  @update_attrs %{
    email: "some updated email",
    username: "some updated username"
  }
  @invalid_attrs %{email: nil, username: nil}

  def fixture(:example) do
    {:ok, example} = Test.create_example(@create_attrs)
    example
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all examples", %{conn: conn} do
      conn = get(conn, Routes.example_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create example" do
    test "renders example when data is valid", %{conn: conn} do
      conn = post(conn, Routes.example_path(conn, :create), example: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.example_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.example_path(conn, :create), example: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update example" do
    setup [:create_example]

    test "renders example when data is valid", %{conn: conn, example: %Example{id: id} = example} do
      conn = put(conn, Routes.example_path(conn, :update, example), example: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.example_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, example: example} do
      conn = put(conn, Routes.example_path(conn, :update, example), example: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete example" do
    setup [:create_example]

    test "deletes chosen example", %{conn: conn, example: example} do
      conn = delete(conn, Routes.example_path(conn, :delete, example))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.example_path(conn, :show, example))
      end
    end
  end

  defp create_example(_) do
    example = fixture(:example)
    %{example: example}
  end
end
