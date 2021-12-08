defmodule Aoc21.Day4 do
  use Bitwise

  def get_bingo_rows(numbers_string) do
    # [[22, 13, 17, 11, 0], [8, 2, 23, 4, 24], ... , [6, 10, 3, 18, 5], [1, 12, 20, 15, 19]]
    # IO.puts(numbers_string)

    numbers_string
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def transpose(rows) do
    Enum.zip_with(rows, fn r -> r end)
  end

  def make_boards(lists, boards, number) do
    [current_list | tail] = lists

    transposed_list = Enum.zip_with(current_list, fn r -> r end)

    # new_boards =
    #   Map.put(
    #     boards,
    #     number,
    #     %{
    #       :rows =>
    #         Map.new(0..4, fn row ->
    #           {row,
    #            Map.new(Enum.at(current_list, row), fn number -> {number, false} end)
    #            |> Map.put(:bingo, 0)}
    #         end),
    #       :cols =>
    #         Map.new(0..4, fn row ->
    #           {row,
    #            Map.new(Enum.at(transposed_list, row), fn number -> {number, false} end)
    #            |> Map.put(:bingo, 0)}
    #         end)
    #     }
    # )
    new_boards =
      boards
      |> Map.put(
        number,
        Map.new(0..9, fn x ->
          if x < 5 do
            {x,
             Map.new(Enum.at(current_list, x), fn number -> {number, false} end)
             |> Map.put(:bingo, 0)}
          else
            {x,
             Map.new(Enum.at(transposed_list, x - 5), fn number -> {number, false} end)
             |> Map.put(:bingo, 0)}
          end
        end)
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

  def process_board(board, bingo_number) do
    Enum.reduce_while(board, {board, ""}, fn {row_no, numbers}, {updated_board, _outcome} ->
      updated_numbers =
        if Map.get(numbers, bingo_number) != nil do
          numbers
          |> Map.replace(bingo_number, true)
          |> Map.update(:bingo, 999, fn x -> x + 1 end)
        else
          numbers
        end

      updated_board = Map.replace(updated_board, row_no, updated_numbers)

      {haltCont, result} =
        if Map.get(updated_numbers, :bingo) == 5 do
          {:halt, {updated_board, :bingo}}
        else
          {:cont, {updated_board, :no_bingo}}
        end

      {haltCont, result}
    end)
  end

  def find_winning_board(boards, numbers) do
    numbers
    |> Enum.reduce_while({boards, %{}, 0}, fn bingo_number, {boards, _current_board, _no} ->
      {result_map, new_outcome, board_no} =
        Enum.reduce_while(boards, {%{}, "", 0}, fn {board_no, board},
                                                   {updated_boards, _outcome, _no} ->
          {updated_board, new_outcome} = process_board(board, bingo_number)

          if new_outcome == :bingo do
            {:halt, {updated_board, :bingo, board_no}}
          else
            {:cont, {Map.put(updated_boards, board_no, updated_board), new_outcome, board_no}}
          end
        end)

      if new_outcome == :bingo do
        {:halt, {result_map, bingo_number, board_no}}
      else
        {:cont, {result_map, :no_bingo, board_no}}
      end
    end)
  end

  def sum_unmarked_numbers({board, final_number, _}) do
    board
    |> Enum.reduce(%{}, fn {_row_no, row}, numbers ->
      Map.merge(numbers, row, fn _, v, _ -> v end)
    end)
    |> Enum.reduce(0, fn {number, status}, sum ->
      if status == false do
        number + sum
      else
        sum
      end
    end)
    |> (fn sum -> sum * final_number end).()
  end

  def part_1(raw_numbers, raw_boards) do
    numbers =
      raw_numbers
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    raw_boards
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&get_bingo_rows/1)
    |> Enum.chunk_every(5)
    |> make_boards(%{}, 0)
    |> (fn boards -> find_winning_board(boards, numbers) end).()
    |> sum_unmarked_numbers()
  end

  def find_winning_boards(boards, numbers, winners) do
    if boards == %{} do
      winners
    else
      {board, final_number, board_no} = find_winning_board(boards, numbers)
      updated_winners = [{board, final_number, board_no} | winners]
      {_, tail} = Map.pop!(boards, board_no)
      find_winning_boards(tail, numbers, updated_winners)
    end
  end

  def part_2(raw_numbers, raw_boards) do
    numbers =
      raw_numbers
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    raw_boards
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&get_bingo_rows/1)
    |> Enum.chunk_every(5)
    |> make_boards(%{}, 0)
    |> (fn boards -> find_winning_boards(boards, numbers, []) end).()
    |> (fn winners ->
          [head | _] = winners
          sum_unmarked_numbers(head)
        end).()
  end
end
