defmodule InAction.ToDoListTest do
  use ExUnit.Case
  doctest ToDoList

  test "Should update Entry" do
    assert ToDoList.new
    |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    |> ToDoList.update_entry(%{date: {2014, 12, 19}, id: 1, title: "Dentist"}) ==
    %ToDoList{auto_id: 2, entries: %{1 => %{date: {2014, 12, 19}, id: 1, title: "Dentist"}}}
  end

  test "Update Entry should check data type" do
    assert_raise FunctionClauseError, fn ->
      ToDoList.update_entry("not valid type", %{date: {2014, 12, 19}, id: 1, title: "Dentist"})
    end
  end

  test "Lambda in Update Entry should return Map" do
    assert_raise MatchError, fn ->
      ToDoList.new
        |> ToDoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
        |> ToDoList.update_entry("Not Map")
    end
  end



end