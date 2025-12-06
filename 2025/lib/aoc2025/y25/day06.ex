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
    problem
    |> String.split("\n", trim: true)
    |> IO.inspect()
    #if i take the first line and find the space before each new character, that is the index where i should split each line
    #then i can come back to this and split each line at that index somehow and give them a column index tuple
    #then i can do a loop where i convert all to integers and find the operation with the matching index and perform that,
    #the in a final reduce add them all


    problem
  end

  # def part_two(problem) do
  #   problem
  # end
end
