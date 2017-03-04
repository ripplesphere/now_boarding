defmodule ElixirStation.DeparturesControllerTest do
  use ElixirStation.ConnCase

  alias ElixirStation.Departures
  @valid_attrs %{destination: "some content", lateness: 42, origin: "some content", scheduled_time: "some content", status: "some content", t_stamp: "some content", track: 42, trip: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, departures_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing departures"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, departures_path(conn, :new)
    assert html_response(conn, 200) =~ "New departures"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, departures_path(conn, :create), departures: @valid_attrs
    assert redirected_to(conn) == departures_path(conn, :index)
    assert Repo.get_by(Departures, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, departures_path(conn, :create), departures: @invalid_attrs
    assert html_response(conn, 200) =~ "New departures"
  end

  test "shows chosen resource", %{conn: conn} do
    departures = Repo.insert! %Departures{}
    conn = get conn, departures_path(conn, :show, departures)
    assert html_response(conn, 200) =~ "Show departures"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, departures_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    departures = Repo.insert! %Departures{}
    conn = get conn, departures_path(conn, :edit, departures)
    assert html_response(conn, 200) =~ "Edit departures"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    departures = Repo.insert! %Departures{}
    conn = put conn, departures_path(conn, :update, departures), departures: @valid_attrs
    assert redirected_to(conn) == departures_path(conn, :show, departures)
    assert Repo.get_by(Departures, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    departures = Repo.insert! %Departures{}
    conn = put conn, departures_path(conn, :update, departures), departures: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit departures"
  end

  test "deletes chosen resource", %{conn: conn} do
    departures = Repo.insert! %Departures{}
    conn = delete conn, departures_path(conn, :delete, departures)
    assert redirected_to(conn) == departures_path(conn, :index)
    refute Repo.get(Departures, departures.id)
  end
end
