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
end
