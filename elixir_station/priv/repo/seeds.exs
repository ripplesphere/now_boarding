# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirStation.Repo.insert!(%ElixirStation.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
# Command for generating repo model
# mix phoenix.gen.html Departures departures
#        t_stamp:string origin:string trip:integer 
#        destination:string scheduled_time:string 
#        lateness:integer track:integer status:string

departures = File.read!("./priv/repo/Departures.csv") |> 
                        String.split("\n", trim: true) |> CSV.decode(headers: true)

try do 
   departures |> Enum.each(fn (row) -> 
         ElixirStation.Repo.insert!(%ElixirStation.Departures{
            t_stamp: row["TimeStamp"],
            origin: row["Origin"],
            trip: String.to_integer(row["Trip"]),
            destination: row["Destination"],
            scheduled_time: row["ScheduledTime"],
            lateness: String.to_integer(row["Lateness"]), 
            track: cond do 
                           row["Track"] == "" -> 0 
                           true -> String.to_integer(row["Track"])
                      end,
            status: row["Status"]})
      end)
rescue
   _ -> IO.puts :rescued
end



