defmodule ToDoList.Map do

  @doc """
    Simple to-do list

    ## Examples

        iex> todo_list = ToDoList.Map.new |>
        ...> ToDoList.Map.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        iex> ToDoList.Map.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, title: "Dentist"}]

        iex> todo_list = ToDoList.Map.new |>
        ...> ToDoList.Map.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        iex> ToDoList.Map.entries(todo_list, {2014, 12, 19})
        []

        iex> todo_list = ToDoList.Map.new |>
        ...> ToDoList.Map.add_entry(%{date: {2013, 12, 19}, title: "Dentist"}) |>
        ...> ToDoList.Map.add_entry(%{date: {2013, 12, 19}, title: "Movie"})
        iex> ToDoList.Map.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, title: "Movie"},%{date: {2013, 12, 19}, title: "Dentist"}]

        iex> todo_list = ToDoList.Map.new |>
        ...> ToDoList.Map.add_entry(%{date: {2013, 12, 19}, title: "Dentist"}) |>
        ...> ToDoList.Map.add_entry(%{date: {2014, 12, 19}, title: "Movie"})
        iex> ToDoList.Map.entries(todo_list, {2013, 12, 19})
        [%{date: {2013, 12, 19}, title: "Dentist"}]

    """

  def new, do: MultiDict.new

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end

end
