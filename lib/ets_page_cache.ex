defmodule EtsPageCache do
  use GenServer

  def init(_) do
    :ets.new(:ets_page_cache, [:set, :named_table, :protected])
    {:ok, nil}
  end

  #interface functions
  def start do
    GenServer.start(__MODULE__, nil)
  end

end
