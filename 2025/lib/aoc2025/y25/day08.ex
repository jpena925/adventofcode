defmodule Aoc2025.Y25.Day08 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    problem
    |> String.split("\n", trim: true)
    |> Enum.map(fn point ->
      [x, y, z] = String.split(point, ",")
      {String.to_integer(x), String.to_integer(y), String.to_integer(z)}
    end)
    |> all_pairs()
    |> Enum.map(fn pair -> calculate_distances(pair) end)
    |> Enum.sort()
    |> IO.inspect()
  end

  defp all_pairs([]), do: []

  defp all_pairs([head | tail]) do
    Enum.map(tail, fn point ->
      {head, point}
    end) ++ all_pairs(tail)
  end

  defp calculate_distances({{x1, y1, z1}, {x2, y2, z2}} = {point1, point2}) do
    {(x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2, point1, point2}
  end

  # def part_two(problem) do
  #   problem
  # end
end
