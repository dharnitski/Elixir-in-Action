defmodule Ets.PageCache.Test do
  use ExUnit.Case

  test "Init ETS table" do
    {:ok, _} = Ets.PageCache.start_link
    Ets.PageCache.cached(:index, &index/0)
    Ets.PageCache.cached(:index, &index/0)
  end

  def index do
	  "<html>...</html>"
  end

end
