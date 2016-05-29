defmodule InAction.ToDoListTest do
  use ExUnit.Case
  doctest ToDoList

  test "Should update Entry" do
    assert ToDoList.new
    |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    |> ToDoList.update_entry(%{date: {2014, 12, 19}, id: 1, title: "Dentist"}) ==
    %ToDoList{auto_id: 2, entries: %{1 => %{date: {2014, 12, 19}, id: 1, title: "Dentist"}}}
  end

  test "Not Existing id should return current data" do
    assert ToDoList.new
    |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    |> ToDoList.update_entry(%{date: {2014, 12, 19}, id: 42, title: "Dentist"}) ==
    %ToDoList{auto_id: 2, entries: %{1 => %{date: {2013, 12, 19}, id: 1, title: "Dentist"}}}
  end

  test "Update Entry should check data type" do
    assert_raise FunctionClauseError, fn ->
      ToDoList.update_entry("not valid type", %{date: {2014, 12, 19}, id: 1, title: "Dentist"})
    end
  end

  test "Lambda in Update Entry should return Map" do
    assert_raise FunctionClauseError, fn ->
      ToDoList.new
        |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        |> ToDoList.update_entry("Not Map")
    end
  end

  test "Deletion of not existing id should keep enrties intact" do
    assert ToDoList.new
    |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    |> ToDoList.delete_entry(2) ==
    %ToDoList{auto_id: 2, entries: %{1 => %{date: {2013, 12, 19}, id: 1, title: "Dentist"}}}
  end

  test "Import from file" do
    todo_list = ToDoList.CsvImporter.import("test/todos.csv")
    assert todo_list == %ToDoList{auto_id: 4,
            entries: %{
              1 => %{date: {2013, 12, 19}, id: 1, title: "Dentist"},
              2 => %{date: {2013, 12, 20}, id: 2, title: "Shopping"},
              3 => %{date: {2013, 12, 19}, id: 3, title: "Movies"}
            }
          }
  end

  test "To String" do
    assert String.Chars.to_string(ToDoList.new()) == "#ToDoList"
  end


end
