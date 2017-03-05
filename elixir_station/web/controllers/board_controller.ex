defmodule ElixirStation.BoardController do
  use ElixirStation.Web, :controller

  alias ElixirStation.Departures

   def index(conn, _params) do

      # Some of this should probably be done in the Departures model but I have yet
      #   to figure that out.
      departures = Repo.all(Departures) |> Enum.map(&(Map.take(&1, 
            [:t_stamp, :origin, :trip, :destination, :scheduled_time,
             :lateness, :track, :status])))
      # And one day I will learn how to do this all in one line of code, until then....
      ecto_time = Enum.map(departures, fn(x) -> DateTime.from_unix!(String.to_integer(x[:scheduled_time])) end)
      h = ecto_time |> Enum.map( fn(x) -> "#{x.hour}" end)
      m = ecto_time |> Enum.map( fn(x) -> "#{x.minute}" end)
      h12 = h |> Enum.map( fn(x) -> cond do String.to_integer(x) > 12 -> Integer.to_string(String.to_integer(x) - 12)
                                             true -> x end end)
      h12s = h |> Enum.map( fn(x) -> cond do String.to_integer(x) > 12 -> " PM"
                                             true -> " AM" end end)
      m2 = m |> Enum.map( fn(x) -> cond do x == "0" -> ":00"
                                             true -> ":" <> x end end)
      zl = List.zip([h12, m2, h12s])
      ft = zl |> Enum.map( fn(x) -> List.to_string(Tuple.to_list(x)) end)
      d_limited = Enum.map(departures, fn(x) -> [x.origin, x.trip, x.destination, x.lateness, x.track, x.status] end)
      d_tmp = List.zip([d_limited, ft])
      d_list = d_tmp |> Enum.map( fn(x) -> Tuple.to_list(x) end )
      d_ready = d_list |> Enum.map( fn(x) -> List.flatten(x) end )

      t_stamp = departures |> Enum.at(0) |> Map.get(:t_stamp)
      # Might format this here but for now sending it to client as is
      ecto_tstamp = DateTime.from_unix!(String.to_integer(t_stamp))

      ready = %{"timestamp" => DateTime.to_naive(ecto_tstamp), "departures" => d_ready}
      
      json conn, ready
   end
end

# Work in progress:
# departures = ElixirStation.Repo.all(ElixirStation.Departures) |> Enum.map(&(Map.take(&1, [:t_stamp, :origin, 
#   :trip, :destination, :scheduled_time, :lateness, :track, :status])))
# d_limited = Enum.map(departures, fn(x) -> [x.origin, x.trip, x.destination, x.lateness, x.track, x.status] end)
#
#t_stamp = departures |> Enum.at(0) |> Map.get(:t_stamp)
#
#ecto_tstamp = DateTime.from_unix!(String.to_integer(t_stamp)
#

