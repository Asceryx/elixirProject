defmodule Project.Repo.Migrations.CreateExamples do
  use Ecto.Migration

  def change do
    create table(:examples) do
      add :username, :string
      add :email, :string

      timestamps()
    end

  end
end
