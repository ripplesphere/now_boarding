defmodule ElixirStation.BoardController do
  use ElixirStation.Web, :controller

   def index(conn, %{"station" => station}) do

      for_station = case station do
                     "south" -> "South Station"
                     "north" -> "North Station"
      end

      query = from "departures", where: [origin: ^for_station], order_by: [:scheduled_time],
               select: [:t_stamp, :trip, :destination, :scheduled_time, :lateness, :track, :status]
      departures = Repo.all(query)

      ecto_time = Enum.map(departures, fn(x) -> DateTime.from_unix!(String.to_integer(x[:scheduled_time])) end)


      h = ecto_time |> Enum.map( fn(x) -> "#{x.hour}" end)
      # 0:00 until 11:59 is AM, 12:00 until 23:59 is PM
      h_per = h |> Enum.map( fn(x) -> cond do 
                     String.to_integer(x) > 11 -> " PM"
                     true -> " AM" end end)
      h12 = h |> Enum.map( fn(x) -> cond do 
                     String.to_integer(x) > 12 -> Integer.to_string(String.to_integer(x) - 12)
                     String.to_integer(x) == 0 -> "12"
                     true -> x end end)
      # Format minutes
      m = ecto_time |> Enum.map( fn(x) -> "#{x.minute}" end) |> 
                       Enum.map( fn(x) -> cond do x == "0" -> ":00"
                                             String.to_integer(x) < 10 -> ":0" <> x
                                             true -> ":" <> x end end)
      zl = List.zip([h12, m, h_per])
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
