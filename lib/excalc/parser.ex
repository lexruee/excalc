defmodule ExCalc.Parser do
  @doc """

  ## Examples

    iex> ExCalc.Parser.tokenize("2 * 3 + 5")
    ["2", "*", "3", "+", "5"]
  """
  def tokenize(input), do: input |> String.split

  def parse(input) do
    input
    |> tokenize
  end
  def mult_div([term1, op, term2 | tail]) when op in ["*", "/"] do
    mult_div([{op, term1, term2} | tail])
  end
  def mult_div([term1, op, term2 | tail]) when op in ["+", "_"] do
    add_sub([term1, op, term2 | tail])
  end
  def mult_div([x]), do: [x]
  def mult_div([]), do: []

  def add_sub([term1, op, term2 | tail]) when op in ["+", "-"] do
    add_sub([{op, term1, term2} | tail])
  end
  def add_sub([term1, op, term2 | tail]) when op in ["*", "/"] do
    mult_div([term1, op, term2 | tail])
  end
  def add_sub([x]), do: [x]
  def add_sub([]), do: []
end
