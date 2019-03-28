defmodule ParserTest do
  use ExUnit.Case
  alias ExCalc.Parser
  doctest Parser

  describe "tokenize" do
    test "expression of form: 1 * 2 * 3" do
      assert ["1", "*", "2", "*", "3"] = Parser.tokenize("1 * 2 * 3")
    end
  end

  describe "parse" do
    test "expression of form: 1 * 2" do
      [{"*", "1", "2"}] = Parser.mult_div(["1", "*", "2"])
    end

    test "expression of form: 1 * 2 * 3" do
      [{ "*", {"*", "1", "2"}, "3"}] = Parser.mult_div(["1", "*", "2", "*", "3"])
    end

    test "expression of form: 1 * 2 * 3 * 4" do
      [{"*", { "*", {"*", "1", "2"}, "3"}, "4"}] = Parser.mult_div(["1", "*", "2", "*", "3", "*", "4"])
    end

    test "expression of form: 1 * 2 + 3" do
      [{"+", {"*", "1", "2"}, "3"}] = Parser.mult_div(["1", "*", "2", "+", "3"])
    end

    test "expression of form: 1 + 2 + 3" do
      [{"+", {"+", "1", "2"}, "3"}] = Parser.add_sub(["1", "+", "2", "+", "3"])
    end

    test "expression of form: 3 + 1 * 2" do
      assert Parser.mult_div(["3", "+", "1", "*", "2"]) == [{"+", "3", {"*", "1", "2"}}]
    end
  end

end
