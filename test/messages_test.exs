defmodule MessagesTest do
  use ExUnit.Case

  test "messages" do
    assert Messages.message()
    |> Enum.sort == ["query 1 result", "query 2 result", "query 3 result",
            "query 4 result", "query 5 result"]
  end
end
