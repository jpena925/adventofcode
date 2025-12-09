defmodule Aoc2025.Y25.Day09 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.stream!(trim: true)
    |> Enum.map(fn line ->
      [x, y] = String.split(line, ",")
      {String.to_integer(x), String.to_integer(y)}
    end)
  end

  def part_one(coords) do
    coords
    |> generate_all_pairs()
    |> Enum.map(fn {{x1, y1}, {x2, y2}} ->
      (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
    end)
    |> Enum.max()
  end

  defp generate_all_pairs(list) do
    indexed = Enum.with_index(list)
    for {a, i} <- indexed, {b, j} <- indexed, i < j, do: {a, b}
  end

  # def part_two(problem) do
  #   problem
  # end
end
