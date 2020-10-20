defmodule Project.Workingtimes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(workingtimes, attrs) do
    workingtimes
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
    |> validate_format(:end, ~r/\d{4}-[0-1]\d-[0-3]\d [0-2]\d:[0-6]\d:[0-6]\d/, [message: "Please input a valid dateFormat"])
    |> validate_format(:start, ~r/\d{4}-[0-1]\d-[0-3]\d [0-2]\d:[0-6]\d:[0-6]\d/, [message: "Please input a valid dateFormat"])
  end
end
