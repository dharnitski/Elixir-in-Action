defmodule KeyValueStore do

  @moduledoc """

    ## Examples

        iex> pid = ServerProcess.start(KeyValueStore)
        iex> ServerProcess.call(pid, {:put, :some_key, :some_value})
        :ok
        iex> ServerProcess.call(pid, {:get, :some_key})
        :some_value
  """

  def init do
    Map.new
  end

  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end
  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end
end
