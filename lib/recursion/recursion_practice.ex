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
  def list_len([head|tail]) do
    1 + list_len(tail)
  end

end
