defmodule ElixirStation.Repo.Migrations.CreateDepartures do
  use Ecto.Migration

  def change do
    create table(:departures) do
      add :t_stamp, :string
      add :origin, :string
      add :trip, :integer
      add :destination, :string
      add :scheduled_time, :string
      add :lateness, :integer
      add :track, :integer
      add :status, :string

      timestamps()
    end

  end
end
