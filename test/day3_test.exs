defmodule AdventOfCode21.Day3Test do
  use ExUnit.Case
  alias Aoc21.Day3

  test "Day3 first" do
    result =
      Day3.first("""
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
      """)

    assert result == 198
  end

  # test "Day3 second" do
  #   result = Day3.second(["forward 5" "down 5", "forward 8", "up 3", "down 8", "forward 2"])
  #   assert result == 900
  # end
end
