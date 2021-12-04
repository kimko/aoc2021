defmodule AdventOfCode21.Day2Test do
  use ExUnit.Case
  alias Aoc21.Day2

  test "Day2 part_1" do
    result = Day2.part_1(["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"])
    assert result == 150
  end

  test "Day2 part_2" do
    result = Day2.part_2(["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"])
    assert result == 900
  end
end
