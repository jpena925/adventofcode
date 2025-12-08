defmodule Aoc2025.Y25.Day07 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.read!()
    |> String.split("\n", trim: true)
  end

  def part_one(rows) do
    [first_row | rest] = rows
    s_col = find_char_index(first_row, "S")

    initial_beams = MapSet.new([s_col])

    {splits, _final_beams} =
      Enum.reduce(rest, {0, initial_beams}, fn row, {split_count, beams} ->
        splitters = find_all_indices(row, "^")

        hits = MapSet.intersection(beams, splitters)

        new_splits = MapSet.size(hits)

        new_beams =
          beams
          |> MapSet.difference(hits)
          |> then(fn remaining ->
            Enum.reduce(hits, remaining, fn hit_pos, acc ->
              acc
              |> MapSet.put(hit_pos - 1)
              |> MapSet.put(hit_pos + 1)
            end)
          end)

        {split_count + new_splits, new_beams}
      end)

    splits
  end

  defp find_char_index(row, char) do
    row
    |> String.graphemes()
    |> Enum.find_index(&(&1 == char))
  end

  defp find_all_indices(row, char) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {c, _idx} -> c == char end)
    |> Enum.map(fn {_c, idx} -> idx end)
    |> MapSet.new()
  end

  def part_two(rows) do
    [first_row | rest] = rows
    s_col = find_char_index(first_row, "S")

    initial_timelines = %{s_col => 1}

    final_timelines =
      Enum.reduce(rest, initial_timelines, fn row, timelines ->
        splitters = find_all_indices(row, "^")

        Enum.reduce(timelines, %{}, fn {col, count}, acc ->
          if MapSet.member?(splitters, col) do
            acc
            |> Map.update(col - 1, count, &(&1 + count))
            |> Map.update(col + 1, count, &(&1 + count))
          else
            Map.update(acc, col, count, &(&1 + count))
          end
        end)
      end)

    final_timelines |> Map.values() |> Enum.sum()
  end
end
