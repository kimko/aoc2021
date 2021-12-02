defmodule Aoc21.Day1 do
  alias Aoc21.Day1

  def get_list_of_integers(file) do
    File.read!("./lib/input/#{file}")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def count_if_greater(new, {_count, _last = 0}) do
    {0, new}
  end

  def count_if_greater(new, {count, last}) do
    if new > last, do: {count + 1, new}, else: {count, new}
  end

  def first(list_of_integers) do
    list_of_integers
    |> Enum.reduce({0, 0}, &Day1.count_if_greater/2)
    |> elem(0)
  end

  def second(list_of_integers) do
    list_of_integers
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.reduce({0, 0}, &Day1.count_if_greater/2)
    |> elem(0)
  end
end
