defmodule DatabaseServerTest do
  use ExUnit.Case

  test "database" do
    DatabaseServer.start
    |> DatabaseServer.run_async("query 1")
    assert DatabaseServer.get_result == "query 1 result"

  end
end
