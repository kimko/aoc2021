defmodule Aoc21 do
  @moduledoc """
  Documentation for `Aoc21`.
  """

  alias Aoc21.Day1
  alias Aoc21.Day2

  def run do
    list = Day1.get_list_of_integers(:day1)
    IO.puts("Day 1 part 1: #{Day1.part_1(list)}")
    IO.puts("Day 2 part 2: #{Day1.part_2(list)}")
    list = Day2.get_list_of_words(:day2)
    IO.puts("Day 2 part 1: #{Day2.part_1(list)}")
    IO.puts("Day 2 part 2: #{Day2.part_2(list)}")
    list = Aoc21.Day3Input.input()
    IO.puts("Day 3 part 1: #{Aoc21.Day3.part_1(list)}")
    IO.puts("Day 3 part 2: #{Aoc21.Day3.part_2(list)}")
  end
end
