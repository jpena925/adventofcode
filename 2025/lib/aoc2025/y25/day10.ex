defmodule Aoc2025.Y25.Day10 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    problem
    |> String.split("\n", trim: true)
    |> parse_everything()

    problem
  end

  def parse_everything(lines) do
    lines
    |> Enum.map(fn line ->
      {parse_pattern(line), parse_buttons(line)}
    end)
  end

  def parse_pattern(line) do
    [_, pattern] = Regex.run(~r/\[([.#]+)\]/, line)

    pattern
    |> String.graphemes()
    |> Enum.map(fn
      "." -> 0
      "#" -> 1
    end)
  end

  def parse_buttons(line) do
    buttons = Regex.scan(~r/\(([0-9,]+)\)/, line)

    buttons
    |> Enum.map(fn [_, button] ->
      button
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # def part_two(problem) do
  #   problem
  # end
end
