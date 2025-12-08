defmodule Aoc2025.Y25.Day08 do
  alias AoC.Input
  @pairs_limit 1000

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    points =
      problem
      |> String.split("\n", trim: true)
      |> Enum.map(fn point ->
        [x, y, z] = String.split(point, ",")
        {String.to_integer(x), String.to_integer(y), String.to_integer(z)}
      end)

    sorted_pairs =
      points
      |> all_pairs()
      |> Enum.map(fn pair -> calculate_distances(pair) end)
      |> Enum.sort()

    parents_map = Map.new(points, fn point -> {point, point} end)

    pairs_to_process = Enum.take(sorted_pairs, @pairs_limit)

    final_parents_map =
      Enum.reduce(pairs_to_process, parents_map, fn {_dist, point1, point2}, pmap ->
        root1 = find_root(point1, pmap)
        root2 = find_root(point2, pmap)

        if root1 != root2 do
          Map.put(pmap, root1, root2)
        else
          pmap
        end
      end)

    circuit_sizes =
      points
      |> Enum.group_by(fn point -> find_root(point, final_parents_map) end)
      |> Enum.map(fn {_root, members} -> length(members) end)
      |> Enum.sort(:desc)

    circuit_sizes
    |> Enum.take(3)
    |> Enum.product()
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

  defp find_root(point, parents_map) do
    parent = Map.get(parents_map, point)

    if parent == point do
      point
    else
      find_root(parent, parents_map)
    end
  end

  # def part_two(problem) do
  #   problem
  # end
end
