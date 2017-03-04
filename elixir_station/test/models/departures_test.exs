defmodule ElixirStation.DeparturesTest do
  use ElixirStation.ModelCase

  alias ElixirStation.Departures

  @valid_attrs %{destination: "some content", lateness: 42, origin: "some content", scheduled_time: "some content", status: "some content", t_stamp: "some content", track: 42, trip: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Departures.changeset(%Departures{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Departures.changeset(%Departures{}, @invalid_attrs)
    refute changeset.valid?
  end
end
