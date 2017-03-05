defmodule ElixirStation.BoardController do
  use ElixirStation.Web, :controller

  alias ElixirStation.Departures

   def index(conn, _params) do

      departures = Repo.all(Departures) |> Enum.map(&(Map.take(&1, 
            [:t_stamp, :origin, :trip, :destination, :scheduled_time,
             :lateness, :track, :status])))


      json conn, departures
   end
end

# Work in progress:
# Enum.map(departures, fn(x) -> %{"origin" => x[:origin], "trip" => x[:trip], "destination" => x[:destination]} end)
# ecto_time = Enum.map(departures, fn(x) -> DateTime.from_unix!(String.to_integer(x[:scheduled_time])) end)
# ecto_time |> Enum.map(fn(x) -> DateTime.to_time(x) end) 
# t_str = dt_time |> Enum.map( fn(x) -> Time.to_string(x) end)
# t_list = t_str |> Enum.map( fn(x) -> String.split(x,":") end)
#
