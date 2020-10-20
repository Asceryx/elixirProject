defmodule Project.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :date
      add :end, :date
      add :id_user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:workingtimes, [:id_user])
  end
end
