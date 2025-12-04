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
    set_of_at_positions =
      problem
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row_num} ->
        transform_to_coordinates(line, row_num)
      end)
      |> MapSet.new()

    set_of_at_positions
    |> Enum.reduce(0, fn {row, column}, acc ->
      neighbor_count =
        Enum.count(@deltas, fn {delta_row, delta_column} ->
          MapSet.member?(set_of_at_positions, {row + delta_row, column + delta_column})
        end)

      if neighbor_count < 4, do: acc + 1, else: acc
    end)
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

  # def part_two(problem) do
  #   problem
  # end
end
