defmodule CalculatorTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "calculate" do
    calculator_pid = Calculator.start
    assert Calculator.value(calculator_pid) == 0
    Calculator.add(calculator_pid, 10)
    Calculator.sub(calculator_pid, 5)
    Calculator.mul(calculator_pid, 3)
    Calculator.div(calculator_pid, 5)
    assert Calculator.value(calculator_pid) == 3.0
  end

  test "Invalid Message" do
    calculator_pid = Calculator.start
    #cannot capture IO from another process
    assert capture_io(fn ->
      send(calculator_pid, {:invalid})
    end) == ""
    # == "invalid request {:invalid}"

  end
end
