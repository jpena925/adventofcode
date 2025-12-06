defmodule Aoc2025.Y25.Day06 do
  alias AoC.Input

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
    lines = String.split(problem, "\n", trim: true)
    column_indexes = find_empty_columns(lines)

    grouped_values =
      [-1 | column_indexes]
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [l, r] -> (l + 1)..(r - 1) end)
      |> Enum.map(fn range ->
        Enum.map(lines, fn line -> String.slice(line, range) end)
      end)

    grouped_values
    |> Enum.map(&perform_operation/1)
    |> Enum.sum()
  end

  defp find_empty_columns(lines) do
    line_length = lines |> hd() |> String.length()

    0..(line_length - 1)
    |> Enum.filter(fn col ->
      Enum.all?(lines, fn line -> String.at(line, col) == " " end)
    end)
    |> Enum.concat([line_length + 1])
  end

  defp perform_operation(problem) do
    trimmed = Enum.map(problem, &String.trim/1)
    {numbers, [op]} = Enum.split(trimmed, -1)

    numbers
    |> Enum.map(&String.to_integer/1)
    |> then(fn nums ->
      case op do
        "*" -> Enum.product(nums)
        "+" -> Enum.sum(nums)
      end
    end)
  end

  # def part_two(problem) do
  #   problem
  # end
end
