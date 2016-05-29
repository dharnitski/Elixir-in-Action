defmodule Circle do
  @moduledoc "Implements basic circle functions"

  @pi 3.14159

  @doc """

    Computes the area of a circle

    ## Examples

        iex> Circle.area(3)
        28.27431
  """
  @spec area(number) :: number
  def area(r), do: r*r*@pi

  @doc """

    Computes the circumference of a circle

    ## Examples

        iex> Circle.circumference(3)
        18.849539999999998
  """
  @spec circumference(number) :: number
  def circumference(r), do: 2*r*@pi

end
