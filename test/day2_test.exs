defmodule AdventOfCode21.Day2Test do
  use ExUnit.Case
  alias Aoc21.Day2

  test "Day2 first" do
    result = Day2.first(["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"])
    assert result == 150
  end

  test "Day2 second" do
    # result = Day2.second([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    # assert result == 5
  end
end
