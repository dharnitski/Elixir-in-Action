defmodule ToDoList do

  @doc """
    Simple to-do list

    ## Examples

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry({2013, 12, 19}, "Dentist")
        #HashDict<[{{2013, 12, 19}, ["Dentist"]}]>
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        ["Dentist"]

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry({2013, 12, 19}, "Dentist")
        iex> ToDoList.entries(todo_list, {2014, 12, 19})
        []

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry({2013, 12, 19}, "Dentist") |>
        ...> ToDoList.add_entry({2013, 12, 19}, "Movies")
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        ["Movies","Dentist"]

        iex> todo_list = ToDoList.new |>
        ...> ToDoList.add_entry({2013, 12, 19}, "Dentist") |>
        ...> ToDoList.add_entry({2014, 12, 19}, "Movies")
        iex> ToDoList.entries(todo_list, {2013, 12, 19})
        ["Dentist"]

    """

  def new, do: HashDict.new

  def add_entry(todo_list, date, title) do
    HashDict.update(todo_list, date, [title],
      fn(titles) -> [title | titles] end
    )
  end

  def entries(todo_list, date) do
    HashDict.get(todo_list, date, [])
  end

end
