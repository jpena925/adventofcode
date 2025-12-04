defmodule Aoc2025.Y25.Day04 do
  alias AoC.Input

  @deltas [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

  def parse(input, _part) do
    # This function will receive the input path or an %AoC.Input.TestInput{}
    # struct. To support the test you may read both types of input with either:
    #
    # * Input.stream!(input), equivalent to File.stream!/1
    # * Input.stream!(input, trim: true), equivalent to File.stream!/2
    # * Input.read!(input), equivalent to File.read!/1
    #
    # The role of your parse/2 function is to return a "problem" for the solve/2
    # function.
    #
    # For instance:
    #
    # input
    # |> Input.stream!()
    # |> Enum.map!(&my_parse_line_function/1)

    Input.read!(input)
  end

  def part_one(problem) do
    set_of_at_positions = build_paper_map(problem)

    set_of_at_positions
    |> Enum.reduce(0, fn {row, column}, acc ->
      if count_neighbors({row, column}, set_of_at_positions) < 4, do: acc + 1, else: acc
    end)
  end

  def part_two(problem) do
    positions = build_paper_map(problem)
    remove_all_accessible_paper(positions, 0)
  end

  defp build_paper_map(problem) do
    problem
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row_num} ->
      transform_to_coordinates(line, row_num)
    end)
    |> MapSet.new()
  end

  defp transform_to_coordinates(line, row_num) do
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce([], fn {char, idx}, acc ->
      case {char, idx} do
        {"@", _} -> [{row_num, idx} | acc]
        _ -> acc
      end
    end)
  end

  defp remove_all_accessible_paper(positions, total_removed) do
    accessible =
      positions
      |> Enum.filter(fn {row, col} ->
        count_neighbors({row, col}, positions) < 4
      end)
      |> MapSet.new()

    if MapSet.size(accessible) == 0 do
      total_removed
    else
      remaining = MapSet.difference(positions, accessible)
      remove_all_accessible_paper(remaining, total_removed + MapSet.size(accessible))
    end
  end

  defp count_neighbors({row, col}, positions) do
    Enum.count(@deltas, fn {delta_row, delta_column} ->
      MapSet.member?(positions, {row + delta_row, col + delta_column})
    end)
  end
end
