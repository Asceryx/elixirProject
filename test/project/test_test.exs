defmodule Project.TestTest do
  use Project.DataCase

  alias Project.Test

  describe "examples" do
    alias Project.Test.Example

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def example_fixture(attrs \\ %{}) do
      {:ok, example} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Test.create_example()

      example
    end

    test "list_examples/0 returns all examples" do
      example = example_fixture()
      assert Test.list_examples() == [example]
    end

    test "get_example!/1 returns the example with given id" do
      example = example_fixture()
      assert Test.get_example!(example.id) == example
    end

    test "create_example/1 with valid data creates a example" do
      assert {:ok, %Example{} = example} = Test.create_example(@valid_attrs)
      assert example.email == "some email"
      assert example.username == "some username"
    end

    test "create_example/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Test.create_example(@invalid_attrs)
    end

    test "update_example/2 with valid data updates the example" do
      example = example_fixture()
      assert {:ok, %Example{} = example} = Test.update_example(example, @update_attrs)
      assert example.email == "some updated email"
      assert example.username == "some updated username"
    end

    test "update_example/2 with invalid data returns error changeset" do
      example = example_fixture()
      assert {:error, %Ecto.Changeset{}} = Test.update_example(example, @invalid_attrs)
      assert example == Test.get_example!(example.id)
    end

    test "delete_example/1 deletes the example" do
      example = example_fixture()
      assert {:ok, %Example{}} = Test.delete_example(example)
      assert_raise Ecto.NoResultsError, fn -> Test.get_example!(example.id) end
    end

    test "change_example/1 returns a example changeset" do
      example = example_fixture()
      assert %Ecto.Changeset{} = Test.change_example(example)
    end
  end
end
