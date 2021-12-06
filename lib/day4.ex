defmodule Aoc21.Day4 do
  use Bitwise

  def get_bingo_rows(numbers_string) do
    # [[22, 13, 17, 11, 0], [8, 2, 23, 4, 24], ... , [6, 10, 3, 18, 5], [1, 12, 20, 15, 19]]
    IO.puts(numbers_string)

    numbers_string
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def make_boards(lists, boards, number) do
    [current_list | tail] = lists

    new_boards =
      Map.put(
        boards,
        number,
        %{
          "rows" =>
            Enum.map(0..4, fn row ->
              Map.new(Enum.at(current_list, row), fn number -> {number, false} end)
            end)
          # "columns" => Map.new(current_list |> Enum.zip |> Enum.map(&Tuple.to_list/1), fn number -> {number, false} end)
        }
      )

    if tail == [] do
      new_boards
    else
      make_boards(
        tail,
        new_boards,
        number + 1
      )
    end
  end

  def part_1(raw_numbers, raw_boards) do
    numbers =
      raw_numbers
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards =
      raw_boards
      |> String.split("\n", trim: true)
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(&get_bingo_rows/1)
      |> Enum.chunk_every(5)
      |> make_boards(%{}, 0)
  end
end
