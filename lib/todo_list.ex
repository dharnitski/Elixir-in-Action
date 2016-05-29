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
        [%{date: {2013, 12, 19}, id: 1, title: "Dentist"},
        %{date: {2013, 12, 19}, id: 2, title: "Movie"}]

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"}) |>
        ...> ToDoList.add_entry(%{date: {2014, 12, 19}, title: "Movie"})
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}]

        iex> ToDoList.new |>
        ...> ToDoList.add_entry("not valid type")
        ** (BadMapError) expected a map, got: "not valid type"

        iex> ToDoList.new |>
        ...> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        iex> ToDoList.entries("not valid type", {2013, 12, 19})
        ** (FunctionClauseError) no function clause matching in ToDoList.entries/2


    """
  defstruct auto_id: 1, entries: Map.new

  def new, do: %ToDoList{}

  def add_entry(
    %ToDoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, auto_id, entry)

    %ToDoList{todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def entries(%ToDoList{entries: entries}, date) do
    entries
    #Stream performs lazy transformation
    |> Stream.filter(fn({_, entry}) ->
         entry.date == date
       end)
    |> Enum.map(fn({_, entry}) ->
         entry
       end)
  end

  @doc """

    Updates existing entry of list

    ## Examples

        iex> ToDoList.new
        ...> |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        ...> |> ToDoList.update_entry(1, &Map.put(&1, :date, {2014, 12, 19}))
        %ToDoList{auto_id: 2, entries: %{1 => %{date: {2014, 12, 19}, id: 1, title: "Dentist"}}}

  """
  def update_entry(
    %ToDoList{entries: entries} = todo_list,
    entry_id,
    updater_fun
  ) do
    case entries[entry_id] do
      nil -> todo_list

      old_entry ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %ToDoList{todo_list | entries: new_entries}
    end
  end

end
