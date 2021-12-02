defmodule AdventOfCode21.Day1Test do
  use ExUnit.Case
  alias Aoc21.Day1

  test "day1 first" do
    result = Day1.first([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert result == 7
  end

  test "day1 second" do
    result = Day1.second([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert result == 5
  end
end
