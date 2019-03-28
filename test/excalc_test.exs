defmodule ExcalcTest do
  use ExUnit.Case
  doctest ExCalc

  test "greets the world" do
    assert ExCalc.hello() == :world
  end
end
