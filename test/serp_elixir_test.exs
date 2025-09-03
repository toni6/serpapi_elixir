defmodule SerpElixirTest do
  use ExUnit.Case
  doctest SerpElixir

  test "simple_quote returns map with stock and price" do
    result = SerpElixir.simple_quote("NVDA:NASDAQ")
    assert is_map(result)
    assert Map.has_key?(result, :stock)
    assert Map.has_key?(result, :price)
    assert is_binary(result.stock)
    assert is_binary(result.price)
  end
end
