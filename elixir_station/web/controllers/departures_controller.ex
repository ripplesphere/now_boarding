defmodule ElixirStation.DeparturesController do
  use ElixirStation.Web, :controller

  alias ElixirStation.Departures

  def index(conn, _params) do
    departures = Repo.all(Departures)
    render(conn, "index.html", departures: departures)
  end

  def new(conn, _params) do
    changeset = Departures.changeset(%Departures{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"departures" => departures_params}) do
    changeset = Departures.changeset(%Departures{}, departures_params)

    case Repo.insert(changeset) do
      {:ok, _departures} ->
        conn
        |> put_flash(:info, "Departures created successfully.")
        |> redirect(to: departures_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    departures = Repo.get!(Departures, id)
    render(conn, "show.html", departures: departures)
  end

  def edit(conn, %{"id" => id}) do
    departures = Repo.get!(Departures, id)
    changeset = Departures.changeset(departures)
    render(conn, "edit.html", departures: departures, changeset: changeset)
  end

  def update(conn, %{"id" => id, "departures" => departures_params}) do
    departures = Repo.get!(Departures, id)
    changeset = Departures.changeset(departures, departures_params)

    case Repo.update(changeset) do
      {:ok, departures} ->
        conn
        |> put_flash(:info, "Departures updated successfully.")
        |> redirect(to: departures_path(conn, :show, departures))
      {:error, changeset} ->
        render(conn, "edit.html", departures: departures, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    departures = Repo.get!(Departures, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(departures)

    conn
    |> put_flash(:info, "Departures deleted successfully.")
    |> redirect(to: departures_path(conn, :index))
  end
end
