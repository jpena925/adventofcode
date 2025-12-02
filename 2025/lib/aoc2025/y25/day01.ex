defmodule Aoc2025.Y25.Day01 do
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
    {dial_number, total_zeroes} =
      problem
      |> String.split("\n")
      |> Enum.reject(fn x -> x == "" end)
      |> Enum.reduce({50, 0}, fn move, acc ->
        if String.first(move) == "L" do
          move_left(move, acc)
        else
          move_right(move, acc)
        end
      end)

    # This function receives the problem returned by parse/2 and must return
    # today's problem solution for part one.
    total_zeroes
  end

  defp move_left(move, {current, total}) do
    move_amount = convert_move_to_int(move)
    next_number = current - move_amount

    final_position = rem(rem(next_number, 100) + 100, 100)
    new_total = if final_position == 0, do: total + 1, else: total

    {final_position, new_total}
  end

  defp move_right(move, {current, total}) do
    move_amount = convert_move_to_int(move)
    next_number = current + move_amount

    final_position = rem(rem(next_number, 100) + 100, 100)
    new_total = if final_position == 0, do: total + 1, else: total

    {final_position, new_total}
  end

  defp convert_move_to_int(move) do
    move
    |> String.slice(1..3)
    |> String.to_integer()
  end

  # def part_two(problem) do
  #   problem
  # end
end
