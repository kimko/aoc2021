defmodule Aoc21 do
  @moduledoc """
  Documentation for `Aoc21`.
  """

  alias Aoc21.Day1
  def run do
    list = Day1.get_list_of_integers(:day1first)
    IO.puts("Day 1 #{Day1.first(list)}")
    IO.puts("Day 2 #{Day1.second(list)}")
  end
end
