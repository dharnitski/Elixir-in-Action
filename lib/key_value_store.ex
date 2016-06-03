defmodule KeyValueStore do
  use GenServer

  @moduledoc """

    ## Examples

        iex> {:ok, pid} = GenServer.start(KeyValueStore, nil)
        iex> GenServer.cast(pid, {:put, :some_key, :some_value})
        :ok
        iex> GenServer.call(pid, {:get, :some_key})
        :some_value

        iex> {:ok, pid} = KeyValueStore.start
        iex> KeyValueStore.put(pid, :some_key, :some_value)
        iex> KeyValueStore.get(pid, :some_key)
        :some_value
  """

  def init(_) do
    {:ok, Map.new}
  end

  #callback functions invoked in the server process
  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  #interface functions run in client process
  def start do
    GenServer.start(KeyValueStore, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end
end
