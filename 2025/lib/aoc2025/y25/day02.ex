defmodule Aoc2025.Y25.Day02 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    total =
      problem
      |> String.trim()
      |> String.split(",")
      |> Enum.reject(fn x -> x == "" end)
      |> Enum.reduce(0, fn range, acc ->
        range_endings = String.split(range, "-")

        if disqualified_range?(range_endings) do
          acc
        else
          acc + check_within_range(range_endings)
        end
      end)

    total
  end

  defp disqualified_range?([first, last]) do
    len_first = String.length(first)
    len_last = String.length(last)

    len_first == len_last and rem(len_first, 2) == 1
  end

  defp check_within_range([first, last]) do
    String.to_integer(first)..String.to_integer(last)
    |> Enum.reduce(0, fn num, acc ->
      num_string = Integer.to_string(num)

      if is_repeated?(num_string), do: acc + num, else: acc
    end)
  end

  defp is_repeated?(num_string) do
    len = String.length(num_string)

    if rem(len, 2) == 1 do
      false
    else
      {left, right} = String.split_at(num_string, div(len, 2))
      left == right
    end
  end

  # def part_two(problem) do
  #   problem
  # end
end
