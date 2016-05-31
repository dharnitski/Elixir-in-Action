defmodule DatabaseServerTest do
  use ExUnit.Case

  test "database" do
    DatabaseServer.start
    |> DatabaseServer.run_async("query 1")
    assert DatabaseServer.get_result == "query 1 result"
  end

  test "pull 100 servers" do
    #start 100 servers
    pool = 1..100
    |> Enum.map(fn(_) -> DatabaseServer.start end)

    1..5
    |> Enum.each(fn(query_def) ->
      #select random process
      server_pid = Enum.at(pool, :random.uniform(100) - 1)
      DatabaseServer.run_async(server_pid, query_def)
    end)

    assert 1..5
    |> Enum.map(fn(_) -> DatabaseServer.get_result end)
    |> Enum.sort == ["1 result", "2 result", "3 result", "4 result", "5 result"]
  end

end
