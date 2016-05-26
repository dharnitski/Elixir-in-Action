defmodule ToDoList do

  @moduledoc """

    CRUD To Do list

    ## Examples

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        iex> ToDoList.entries(todo_list, {2014, 12, 19})
        []

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"}) |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Movie"})
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, id: 2, title: "Movie"},
        %{date: {2013, 12, 19}, id: 1, title: "Dentist"}]

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"}) |>
        ...> ToDoList.add_entry(%{date: {2014, 12, 19}, title: "Movie"})
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]

    """
  defstruct auto_id: 1, entries: HashDict.new

  def new, do: %ToDoList{}

  def add_entry(
    %ToDoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = HashDict.put(entries, auto_id, entry)

    %ToDoList{todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def entries(%ToDoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn({_, entry}) ->
         entry.date == date
       end)
    |> Enum.map(fn({_, entry}) ->
         entry
       end)
  end

end
