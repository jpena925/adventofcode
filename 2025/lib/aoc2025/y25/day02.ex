defmodule Aoc2025.Y25.Day02 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    total =
      problem
      # for testing
      |> String.trim()
      |> String.split(",")
      |> Enum.reject(fn x -> x == "" end)
      |> Enum.reduce(0, fn range, acc ->
        range_endings = String.split(range, "-")

        if disqualified_range?(range_endings) do
          IO.puts("BAD RANGE")
          acc
        else
          IO.puts("Need to check this range")
        end
      end)

    total
  end

  defp disqualified_range?([first, last]) do
    len_first = String.length(first)
    len_last = String.length(last)

    len_first == len_last and rem(len_first, 2) == 1
  end

  # def part_two(problem) do
  #   problem
  # end
end
