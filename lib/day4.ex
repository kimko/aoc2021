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

  def process_rows_cols(board, bingo_number) do
    # [head | tail] = rowcols
    # IO.puts("#{bingo_number} #{head} #{board_no} #{type} #{head}")
    IO.puts("process_rows_cols #{bingo_number}")
    {board, :eh}
    # get_and_update_in(boards, )
    # if get_in(board, [type, head, bingo_number]) == false do
    #   updated_boards = boards
    #   |> put_in([board_no, type, head, bingo_number], true)
    #   |> put_in([board_no, type, head, :bingo], get_in(boards, [board_no, type, head, :bingo]) + 1)
    #   updated_bingo = get_in(updated_boards, [board_no, type, head, :bingo])
    # end
    #   if tail == []|> process_rows_cols(bingo_number, board_no, tail, type)
    # end
  end

  # def process_number(boards, bingo_number, board_numbers) do
  #   [head | tail] = board_numbers

  #   updated_boards = board_numbers
  #   |> Enum.reduce_while(boards, fn number, boards ->
  #     {:halt, }
  #     # {result, board}= process_rows_cols(get_in(boards, [board_number, :cols], bingo_number, Enum.to_list(0..4))
  #     # {result, Map.put(acc, board_number, board)}
  #   end)
  #   # |> process_rows_cols(bingo_number, head, Enum.to_list(0..4), :rows)
  #   if tail != [] do
  #     process_number(updated_boards, bingo_number, tail)
  #   else
  #     updated_boards
  #   end
  # end

  def find_winning_board(boards, numbers, board_count, iteration, _winner = nil) do
    [head | tail] = numbers

    if tail == [] do
      raise "no winner"
    else
      numbers
      |> Enum.reduce_while({boards, %{}}, fn bingo_number, {boards, _current_board} ->
        IO.puts("next bingo number #{bingo_number}")
        IO.puts(inspect(boards))

        # updated_boards = Enum.reduce(boards, %{}, fn {number, board}, updated_boards -> Map.put(updated_boards, number ,update_in(board, [ :cols, 0, :bingo], &(&1 + 1)))end)
        {result_map, new_outcome} =
          Enum.reduce_while(boards, {%{}, ""}, fn {key, board}, {updated_boards, _outcome} ->
            {updated_board, new_outcome} = process_rows_cols(board, bingo_number)
            IO.puts("result #{new_outcome}")
            IO.puts(inspect(%{key => updated_board}))

            if new_outcome == :bingo do
              {:halt, {updated_board, :bingo}}
            else
              {:cont, {Map.put(updated_boards, key, updated_board), new_outcome}}
            end

            # else
            # {:halt, {updated_boards, :shrug}}
            # end
          end)

        if new_outcome == :bingo do
          {:halt, {result_map, :bingo}}
        else
          {:cont, {result_map, :no_bingo}}
        end
      end)
    end
  end

  def find_winning_board(_, _, _, _, winner) do
    winner
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
    |> (fn boards -> find_winning_board(boards, numbers, Enum.count(boards), 0, nil) end).()
  end
end
