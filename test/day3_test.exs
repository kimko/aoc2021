defmodule AdventOfCode21.Day3Test do
  use ExUnit.Case
  alias Aoc21.Day3

  test "Day3 part_1" do
    result =
      Day3.part_1("""
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

  test "Day3 part_2" do
    result =
      Day3.part_2("""
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

    assert result == 230
  end
end
