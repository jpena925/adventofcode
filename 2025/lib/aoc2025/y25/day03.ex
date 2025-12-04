defmodule Aoc2025.Y25.Day03 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    problem
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      acc + get_largest_two_digits(line)
    end)
  end

  defp get_largest_two_digits(line) do
    {_curr_max, right_maxes} =
      line
      |> String.reverse()
      |> String.to_charlist()
      |> Enum.reduce({0, []}, fn num, {running_max, list} ->
        {max(running_max, num), [running_max | list]}
      end)

    original = String.to_charlist(line)

    right_maxes
    |> Enum.drop(-1)
    |> Enum.zip(original)
    |> Enum.map(fn {m, d} -> (d - ?0) * 10 + (m - ?0) end)
    |> Enum.max()
  end

  def part_two(problem) do
    problem
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      acc + get_largest_twelve_digits(line)
    end)
  end

  defp get_largest_twelve_digits(line) do
    charlist = String.to_charlist(line)
    pick_digits(charlist, 0, 12, [])
  end

  defp pick_digits(_charlist, _start, 0, acc) do
    acc
    |> Enum.reverse()
    |> convert_to_integer()
  end

  defp pick_digits(charlist, start, remaining, acc) do
    {big_number, max_index} = charlist
    |> Enum.slice(start, length(charlist) - start - (remaining - 1))
    |> Enum.with_index()
    |> Enum.reduce({0, 0}, fn {num, index}, {max, max_index} ->
      if num > max do
        {num, index}
      else
        {max, max_index}
      end
    end)

    pick_digits(charlist, start + max_index + 1, remaining - 1, [big_number | acc])
  end

  defp convert_to_integer(charlist) do
    charlist
    |> List.to_string()
    |> String.to_integer()
  end
end
