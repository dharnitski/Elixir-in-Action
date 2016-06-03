defmodule TodoGenServer do
  use GenServer

  def init(_) do
    {:ok, ToDoList.new}
  end

  #callback functions invoked in the server process
  def handle_cast({:add_entry, new_entry}, state) do
    {:noreply, ToDoList.add_entry(state, new_entry)}
  end
  def handle_cast({:delete_entry, entry_id}, state) do
    {:noreply, ToDoList.delete_entry(state, entry_id)}
  end
  def handle_cast({:update_entry, entry}, state) do
    {:noreply, ToDoList.update_entry(state, entry)}
  end

  def handle_call({:entries, date}, _, state) do
    {:reply, ToDoList.entries(state, date), state}
  end

  #interface functions
  def start do
    GenServer.start(TodoGenServer, nil)
  end

  def add_entry(pid, new_entry) do
    GenServer.cast(pid, {:add_entry, new_entry})
  end

  def delete_entry(pid, entry_id) do
    GenServer.cast(pid, {:delete_entry, entry_id})
  end

  def update_entry(pid, %{} = new_entry) do
    GenServer.cast(pid, {:update_entry, new_entry})
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

end
