defmodule Aoc21.Day3 do
  use Bitwise

  def sum_list_and_compare_to_length(list, length) do
    if Enum.sum(list) > length do
      1
    else
      0
    end
  end

  def calculate_gamma_and_epsilon_char_list(gamma_element, [gamma, epsilon]) do
    [
      [gamma_element |> Integer.to_string() | gamma],
      [1 >>> gamma_element |> Integer.to_string() | epsilon]
    ]
  end

  def base2_char_list_to_decimal(char_list) do
    char_list
    |> List.to_string()
    |> Integer.parse(2)
    |> elem(0)
  end

  def convert_list_of_chars_to_list_of_integers(list) do
    list |> Enum.map(&String.to_integer/1)
  end

  def first(raw_list) do
    list = raw_list |> String.split("\n", trim: true)
    length = Enum.count(list) / 2

    list
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&convert_list_of_chars_to_list_of_integers/1)
    |> Enum.reduce([], fn list, acc ->
      [sum_list_and_compare_to_length(list, length) | acc]
    end)
    |> Enum.reduce([[], []], &calculate_gamma_and_epsilon_char_list/2)
    |> (fn [gamma_list, epsilon_list] ->
          base2_char_list_to_decimal(gamma_list) * base2_char_list_to_decimal(epsilon_list)
        end).()
  end

  def base2_integer_list_to_decimal(int_list) do
    int_list
    |> Enum.map(&Integer.to_string/1)
    |> List.to_string()
    |> Integer.parse(2)
    |> elem(0)
  end

  def get_filter(sum, length, _rating = :oxygen_generator) do
    if sum >= length / 2 do
      1
    else
      0
    end
  end

  def get_filter(sum, length, _rating = :co2_scrubber) do
    if sum < length / 2 do
      1
    else
      0
    end
  end

  def compute(input_lists, sum, length, position, rating) do
    new_input_lists =
      input_lists
      |> Enum.filter(fn list -> Enum.at(list, position) == get_filter(sum, length, rating) end)

    new_input_lists
  end

  def calculate_rating(input_lists, position, rating) do
    [head | tail] = input_lists

    if tail == [] do
      head
    else
      column = input_lists |> Enum.zip() |> Enum.map(&Tuple.to_list/1) |> Enum.at(position)
      sum = Enum.sum(column)
      length = Enum.count(column)
      new_input_lists = compute(input_lists, sum, length, position, rating)
      calculate_rating(new_input_lists, position + 1, rating)
    end
  end

  def second(input) do
    base_list =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.codepoints/1)
      |> Enum.reduce([], fn list, acc -> [Enum.map(list, &String.to_integer/1) | acc] end)

    oxygen =
      base_list
      |> calculate_rating(0, :oxygen_generator)
      |> base2_integer_list_to_decimal

    co2 =
      base_list
      |> calculate_rating(0, :co2_scrubber)
      |> base2_integer_list_to_decimal

    oxygen * co2
  end
end
