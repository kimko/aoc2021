defmodule Aoc21.Day2 do
  alias Aoc21.Day2

  def get_list_of_words(file) do
    File.read!("./lib/input/#{file}")
    |> String.split("\n")
  end

  def navigate([_command = "forward", value], {hor, dep}) do
    # IO.puts("Forward #{value} #{hor + value}")
    {hor + value, dep}
  end

  def navigate([_command = "down", value], {hor, dep}) do
    # IO.puts("Down #{value} #{dep}")
    {hor, dep + value}
  end

  def navigate([_command = "up", value], {hor, dep}) do
    # IO.puts("Up #{value} #{dep}")
    {hor, dep - value}
  end

  def first(raw_list) do
    # require IEx; IEx.pry
    {horizontal, depth} =
      raw_list
      |> Enum.map(&String.split/1)
      |> Enum.map(fn [c, v] -> [c, String.to_integer(v)] end)
      |> Enum.reduce({0, 0}, &Day2.navigate/2)

    IO.puts("Horizontal: #{horizontal} Depth: #{depth}")
    horizontal * depth
  end

  def second(list_of_integers) do
    # list_of_integers
    # |> Enum.chunk_every(3, 1, :discard)
    # |> Enum.map(&Enum.sum/1)
    # |> Enum.reduce({0, 0}, &Day2.count_if_greater/2)
    # |> elem(0)
  end
end
