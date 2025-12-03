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

  # def part_two(problem) do
  #   problem
  # end
end
