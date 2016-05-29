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

  @doc """

    New To Do List

    ## Examples

    iex> ToDoList.new([
    ...> %{date: {2013, 12, 19}, title: "Dentist"},
    ...> %{date: {2014, 12, 19}, title: "Movie"}
    ...> ])
    %ToDoList{auto_id: 3, entries: %{1 => %{date: {2013, 12, 19}, id: 1, title: "Dentist"}, 2 => %{date: {2014, 12, 19}, id: 2, title: "Movie"}}}
  """

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %ToDoList{},
      &add_entry(&2, &1)
    )
  end

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

  @doc """

    Deletes existing entry by id

    ## Examples

        iex> ToDoList.new
        ...> |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        ...> |> ToDoList.delete_entry(1)
        %ToDoList{auto_id: 2, entries: %{}}
  """

  def delete_entry(
    %ToDoList{entries: entries} = todo_list,
    entry_id) do
      case entries[entry_id] do
        nil -> todo_list

        entry ->
          new_entries = Map.delete(entries, entry.id)
          %ToDoList{todo_list | entries: new_entries}
      end
  end

end

defmodule ToDoList.CsvImporter do

  def import(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(fn(line) -> map_line(line) end)
    |> ToDoList.new
  end

  defp map_line(line) do
    [date | title] = String.split(line, ",")
    %{date: parse_date(date), title: hd(title)}
  end

  defp parse_date(date) do
    String.split(date, "/")
    |> Enum.map(fn (part) -> String.to_integer(part) end)
    |> List.to_tuple
  end

end
