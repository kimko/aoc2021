defmodule Aoc21 do
  @moduledoc """
  Documentation for `Aoc21`.
  """

  alias Aoc21.Day1
  alias Aoc21.Day2

  def run do
    list = Day1.get_list_of_integers(:day1first)
    IO.puts("Day 1 first : #{Day1.first(list)}")
    IO.puts("Day 2 second: #{Day1.second(list)}")
    list = Day2.get_list_of_words(:day2)
    IO.puts("Day 2 first : #{Day2.first(list)}")
    IO.puts("Day 2 second: #{Day2.second(list)}")
    list = Aoc21.Day3Input.input()
    IO.puts("Day 3 first : #{Aoc21.Day3.first(list)}")
    IO.puts("Day 3 second: #{Aoc21.Day3.second(list)}")
  end
end
