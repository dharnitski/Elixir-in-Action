defmodule InAction.Recursion do

  @doc """
    Computes number of items in list

    ## Examples

        iex> InAction.Recursion.list_len([1, 2, 3, 4])
        4

        iex> InAction.Recursion.list_len([1])
        1

        iex> InAction.Recursion.list_len([])
        0

    """
  def list_len([]) do
    0
  end
  def list_len([_|tail]) do
    1 + list_len(tail)
  end

  @doc """
    Computes list of items in a given range

    ## Examples

        #executed for 8 seconds
        #iex> InAction.Recursion.range(0, 100000000)
        #100000000

        iex> InAction.Recursion.range(0, 10)
        10

        iex> InAction.Recursion.range(10, 10)
        0

        iex> InAction.Recursion.range(10, 5)
        0

    """
  def range(from, to) when from >= to do
    0
  end
  def range(from, to) do
    1 + range(from + 1, to)
  end

end
