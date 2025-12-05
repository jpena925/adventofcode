defmodule Aoc2025.Y25.Day05 do
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

  # def part_two(problem) do
  #   problem
  # end
end
