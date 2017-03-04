defmodule ElixirStation.Departures do
  use ElixirStation.Web, :model

  schema "departures" do
    field :t_stamp, :string
    field :origin, :string
    field :trip, :integer
    field :destination, :string
    field :scheduled_time, :string
    field :lateness, :integer
    field :track, :integer
    field :status, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:t_stamp, :origin, :trip, :destination, :scheduled_time, :lateness, :track, :status])
    |> validate_required([:t_stamp, :origin, :trip, :destination, :scheduled_time, :lateness, :track, :status])
  end
end
