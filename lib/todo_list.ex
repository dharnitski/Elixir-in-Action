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
        # replace date for entry with id = 1
        iex> ToDoList.new
        ...> |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        ...> |> ToDoList.update_entry(1, &Map.put(&1, :date, {2014, 12, 19}))
        %ToDoList{auto_id: 2, entries: %{1 => %{date: {2014, 12, 19}, id: 1, title: "Dentist"}}}

        # try to replace date for not existing id - should return original data
        iex> ToDoList.new
        ...> |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        ...> |> ToDoList.update_entry(11, &Map.put(&1, :date, {2014, 12, 19}))
        %ToDoList{auto_id: 2, entries: %{1 => %{date: {2013, 12, 19}, id: 1, title: "Dentist"}}}

        # type check for data
        iex> ToDoList.update_entry("not valid type", 1, &Map.put(&1, :date, {2014, 12, 19}))
        ** (FunctionClauseError) no function clause matching in ToDoList.update_entry/3

        # type check for lambda return value
        iex> ToDoList.new
        ...> |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        ...> |> ToDoList.update_entry(1, &Map.to_list(&1))
        ** (MatchError) no match of right hand side value: [date: {2013, 12, 19}, id: 1, title: "Dentist"]

        # check that lambda cannot change id
        iex> ToDoList.new
        ...> |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        ...> |> ToDoList.update_entry(1, &Map.put(&1, :id, 42))
        ** (MatchError) no match of right hand side value: %{date: {2013, 12, 19}, id: 42, title: "Dentist"}
  """
  def update_entry(
    %ToDoList{entries: entries} = todo_list,
    entry_id,
    updater_fun
  ) do
    case entries[entry_id] do
      nil -> todo_list

      old_entry ->
        old_entry_id = old_entry.id
        # %{} generates MatchError for wrong lambda result type
        # %{id: ^old_entry_id} checks that id not mutated
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %ToDoList{todo_list | entries: new_entries}
    end
  end
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn(_) -> new_entry end)
  end

end
