defmodule CalculatorTest do
  use ExUnit.Case

  test "calculate" do
    calculator_pid = Calculator.start
    assert Calculator.value(calculator_pid) == 0
    Calculator.add(calculator_pid, 10)
    Calculator.sub(calculator_pid, 5)
    Calculator.mul(calculator_pid, 3)
    Calculator.div(calculator_pid, 5)
    assert Calculator.value(calculator_pid) == 3.0
  end
end  
