defmodule TodoServer do
  def start do
    spawn (fn -> loop(ToDoList.new) end)
  end

  def add_entry(todo_server, new_entry) do
    send(todo_server, {:add_entry, new_entry})
  end

  def delete_entry(todo_server, entry_id) do
    send(todo_server, {:delete_entry, entry_id})
  end

  def update_entry(todo_server, %{} = new_entry) do
    send(todo_server, {:update_entry, new_entry})
  end

  def entries(todo_server, date) do
    send(todo_server, {:entries, self, date})

    receive do
      {:todo_entries, entries} -> entries
    after 5000 ->
      {:error, :timeout}
    end
  end

  defp loop(todo_list) do
    new_todo_list = receive do
      message -> process_message(todo_list, message)
    end

    loop(new_todo_list)
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    ToDoList.add_entry(todo_list, new_entry)
  end
  defp process_message(todo_list, {:delete_entry, entry_id}) do
    ToDoList.delete_entry(todo_list, entry_id)
  end
  defp process_message(todo_list, {:update_entry, entry}) do
    ToDoList.update_entry(todo_list, entry)
  end
  defp process_message(todo_list, {:entries, caller, date}) do
    send(caller, {:todo_entries, ToDoList.entries(todo_list, date)})
    todo_list
  end

end
