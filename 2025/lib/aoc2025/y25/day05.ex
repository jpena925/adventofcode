defmodule Aoc2025.Y25.Day05 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    [fresh_ranges, item_numbers] = String.split(problem, "\n\n", trim: true)
    fresh_ranges_list = parse_ranges(fresh_ranges)

    item_numbers
    |> String.split("\n", trim: true)
    |> Enum.count(fn num_string ->
      num = String.to_integer(num_string)
      Enum.any?(fresh_ranges_list, fn {min, max} -> num >= min and num <= max end)
    end)
  end

  def parse_ranges(range) do
    range
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [a, b] = String.split(s, "-")
      {String.to_integer(a), String.to_integer(b)}
    end)
  end

  def part_two(problem) do
    [fresh_ranges, _item_numbers] = String.split(problem, "\n\n", trim: true)

    fresh_ranges
    |> parse_ranges()
    |> Enum.sort()
    |> merge()
    |> Enum.map(fn {min, max} -> max - min + 1 end)
    |> Enum.sum()
  end

  defp merge([first | rest]) do
    Enum.reduce(rest, [first], fn {min, max}, [{prev_min, prev_max} | acc] ->
      if min <= prev_max + 1 do
        [{prev_min, max(prev_max, max)} | acc]
      else
        [{min, max}, {prev_min, prev_max} | acc]
      end
    end)
    |> Enum.reverse()
  end
end
