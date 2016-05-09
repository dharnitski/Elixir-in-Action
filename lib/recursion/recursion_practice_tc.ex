defmodule InAction.Recursion.Tc do

  @moduledoc "Tail Recursion version of Recursion tests"

  @doc """
    Computes number of items in list

    ## Examples

        iex> InAction.Recursion.Tc.list_len([1, 2, 3, 4])
        4

        iex> InAction.Recursion.Tc.list_len([1])
        1

        iex> InAction.Recursion.Tc.list_len([])
        0

    """

  def list_len(list) do
    do_list_len(0, list)
  end

  defp do_list_len(accumulator, []) do
    accumulator
  end
  defp do_list_len(accumulator, [_|tail]) do
    accumulator + 1
    |> do_list_len(tail)
  end

  @doc """
    Computes list of items in a given range

    ## Examples

      #executed for 1.6 seconds vs >8 sec in not Tail Recurced version
      #iex> InAction.Recursion.Tc.range(0, 100000000)
      #100000000

        iex> InAction.Recursion.Tc.range(0, 100)
        100

        iex> InAction.Recursion.Tc.range(10, 10)
        0

        iex> InAction.Recursion.Tc.range(10, 5)
        0

    """
  def range(from, to) do
    do_range(0, from, to)
  end

  defp do_range(accumulator, from, to) when from >= to do
    accumulator
  end
  defp do_range(accumulator, from, to) do
    accumulator + 1
    |> do_range(from + 1, to)
  end

end
