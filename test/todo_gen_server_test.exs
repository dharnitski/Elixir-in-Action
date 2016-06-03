defmodule InAction.TodoGenServerTest do
  use ExUnit.Case

  test "Add Entry" do
    {:ok, todo_server} = TodoGenServer.start
    TodoGenServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoGenServer.add_entry(todo_server, %{date: {2013, 12, 20}, title: "Shopping"})
    TodoGenServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Movies"})
    assert TodoGenServer.entries(todo_server, {2013, 12, 19}) ==
    [
      %{date: {2013, 12, 19}, id: 1, title: "Dentist"},
      %{date: {2013, 12, 19}, id: 3, title: "Movies"}
    ]
  end

  test "Delete Entry" do
    {:ok, todo_server} = TodoGenServer.start
    TodoGenServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoGenServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Movies"})
    TodoGenServer.delete_entry(todo_server, 2)
    assert TodoGenServer.entries(todo_server, {2013, 12, 19}) ==
    [
      %{date: {2013, 12, 19}, id: 1, title: "Dentist"},
    ]
  end

  test "Update Entry" do
    {:ok, todo_server} = TodoGenServer.start
    TodoGenServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoGenServer.update_entry(todo_server, %{date: {2013, 12, 20}, id: 1, title: "Movie"})
    assert TodoGenServer.entries(todo_server, {2013, 12, 20}) ==
    [
      %{date: {2013, 12, 20}, id: 1, title: "Movie"},
    ]
  end
end
