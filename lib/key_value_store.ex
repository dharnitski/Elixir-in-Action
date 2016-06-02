defmodule KeyValueStore do

  @moduledoc """

    ## Examples

        iex> pid = ServerProcess.start(KeyValueStore)
        iex> ServerProcess.call(pid, {:put, :some_key, :some_value})
        :ok
        iex> ServerProcess.call(pid, {:get, :some_key})
        :some_value

        iex> pid = KeyValueStore.start
        iex> KeyValueStore.put(pid, :some_key, :some_value)
        iex> KeyValueStore.get(pid, :some_key)
        :some_value
  """

  def init do
    Map.new
  end

  #callback functions invoked in the server process
  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end
  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end

  #interface functions run in client process
  def start do
    ServerProcess.start(KeyValueStore)
  end

  def put(pid, key, value) do
    ServerProcess.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end
end
