defmodule ToDoList.Simple do

  @doc """
    Simple to-do list

    ## Examples

        iex> todo_list = ToDoList.Simple.new |>
        ...> ToDoList.Simple.add_entry({2013, 12, 19}, "Dentist")
        #HashDict<[{{2013, 12, 19}, ["Dentist"]}]>
        iex> ToDoList.Simple.entries(todo_list, {2013, 12, 19})
        ["Dentist"]

        iex> todo_list = ToDoList.Simple.new |>
        ...> ToDoList.Simple.add_entry({2013, 12, 19}, "Dentist")
        iex> ToDoList.Simple.entries(todo_list, {2014, 12, 19})
        []

        iex> todo_list = ToDoList.Simple.new |>
        ...> ToDoList.Simple.add_entry({2013, 12, 19}, "Dentist") |>
        ...> ToDoList.Simple.add_entry({2013, 12, 19}, "Movies")
        iex> ToDoList.Simple.entries(todo_list, {2013, 12, 19})
        ["Movies","Dentist"]

        iex> todo_list = ToDoList.Simple.new |>
        ...> ToDoList.Simple.add_entry({2013, 12, 19}, "Dentist") |>
        ...> ToDoList.Simple.add_entry({2014, 12, 19}, "Movies")
        iex> ToDoList.Simple.entries(todo_list, {2013, 12, 19})
        ["Dentist"]

    """

  def new, do: MultiDict.new

  def add_entry(todo_list, date, title) do
    MultiDict.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end

end
