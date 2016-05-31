defmodule InAction.TodoServerTest do
  use ExUnit.Case

  test "Add Entry" do
    todo_server = TodoServer.start
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 20}, title: "Shopping"})
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Movies"})
    assert TodoServer.entries(todo_server, {2013, 12, 19}) ==
    [
      %{date: {2013, 12, 19}, id: 1, title: "Dentist"},
      %{date: {2013, 12, 19}, id: 3, title: "Movies"}
    ]
  end

  test "Delete Entry" do
    todo_server = TodoServer.start
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Movies"})
    TodoServer.delete_entry(todo_server, 2)
    assert TodoServer.entries(todo_server, {2013, 12, 19}) ==
    [
      %{date: {2013, 12, 19}, id: 1, title: "Dentist"},
    ]
  end

  test "Update Entry" do
    todo_server = TodoServer.start
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoServer.update_entry(todo_server, %{date: {2013, 12, 20}, id: 1, title: "Movie"})
    assert TodoServer.entries(todo_server, {2013, 12, 20}) ==
    [
      %{date: {2013, 12, 20}, id: 1, title: "Movie"},
    ]
  end
end
