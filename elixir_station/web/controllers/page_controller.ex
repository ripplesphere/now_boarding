defmodule ElixirStation.PageController do
  use ElixirStation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
