defmodule Aoc2025.Y25.Day01 do
  alias AoC.Input

  def parse(input, _part) do
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
