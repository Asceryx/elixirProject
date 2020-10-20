defmodule ProjectWeb.ExampleView do
  use ProjectWeb, :view
  alias ProjectWeb.ExampleView

  def render("index.json", %{examples: examples}) do
    %{data: render_many(examples, ExampleView, "example.json")}
  end

  def render("show.json", %{example: example}) do
    %{data: render_one(example, ExampleView, "example.json")}
  end

  def render("example.json", %{example: example}) do
    %{id: example.id,
      username: example.username,
      email: example.email}
  end
end
