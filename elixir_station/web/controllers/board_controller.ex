defmodule ElixirStation.BoardController do
  use ElixirStation.Web, :controller

   def index(conn, %{"station" => station}) do

      # Some of this should probably be done in the Departures model but I have yet
      #   to figure that out.
      for_station = case station do
         "south" ->
            "South Station"
         "north" -> 
            "North Station"
      end
      query = from "departures", where: [origin: ^for_station], order_by: [:scheduled_time],
               select: [:t_stamp, :trip, :destination, :scheduled_time, :lateness, :track, :status]
      departures = Repo.all(query)
      # And one day I will learn how to do this all in one line of code, until then....
      ecto_time = Enum.map(departures, fn(x) -> DateTime.from_unix!(String.to_integer(x[:scheduled_time])) end)
      h = ecto_time |> Enum.map( fn(x) -> "#{x.hour}" end)
      m = ecto_time |> Enum.map( fn(x) -> "#{x.minute}" end)
      h12 = h |> Enum.map( fn(x) -> cond do String.to_integer(x) > 12 -> Integer.to_string(String.to_integer(x) - 12)
                                             true -> x end end)
      hm = h |> Enum.map( fn(x) -> cond do String.to_integer(x) == 0 -> "12"
                                             true -> x end end)
      h12s = hm|> Enum.map( fn(x) -> cond do String.to_integer(x) > 12 -> " PM"
                                             true -> " AM" end end)
      m2 = m |> Enum.map( fn(x) -> cond do x == "0" -> ":00"
                                             String.to_integer(x) < 10 -> ":0" <> x
                                             true -> ":" <> x end end)
      zl = List.zip([h12, m2, h12s])
      ft = zl |> Enum.map( fn(x) -> List.to_string(Tuple.to_list(x)) end)
      d_limited = Enum.map(departures, fn(x) -> [x.trip, x.destination, x.lateness, x.track, x.status] end)
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

