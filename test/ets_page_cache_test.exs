defmodule EtsPageCache.Test do
  use ExUnit.Case

  test "Init ETS table" do
    {:ok, _} = EtsPageCache.start
  end

end
