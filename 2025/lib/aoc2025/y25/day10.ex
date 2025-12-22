defmodule Aoc2025.Y25.Day10 do
  alias AoC.Input
  import Bitwise

  def parse(input, _part) do
    Input.read!(input)
  end

  def part_one(problem) do
    problem
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&find_min_presses/1)
    |> Enum.sum()
  end

  def parse_line(line) do
    {parse_pattern(line), parse_buttons(line)}
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

  def find_min_presses({target, buttons}) do
    num_lights = length(target)
    num_buttons = length(buttons)

    button_masks =
      Enum.map(buttons, fn button ->
        button_to_mask(button, num_lights)
      end)

    0..(Integer.pow(2, num_buttons) - 1)
    |> Enum.filter(fn combination ->
      combined = apply_combination(combination, button_masks, num_lights)
      combined == target
    end)
    |> Enum.map(fn combination ->
      count_bits(combination)
    end)
    |> Enum.min()
  end

  def button_to_mask(button, num_lights) do
    Enum.map(0..(num_lights - 1), fn position ->
      if position in button, do: 1, else: 0
    end)
  end

  def apply_combination(combination, button_masks, num_lights) do
    start = List.duplicate(0, num_lights)

    button_masks
    |> Enum.with_index()
    |> Enum.reduce(start, fn {mask, button_index}, acc ->
      if (combination &&& 1 <<< button_index) != 0 do
        xor_lists(acc, mask)
      else
        acc
      end
    end)
  end

  def xor_lists(list1, list2) do
    Enum.zip_with(list1, list2, fn a, b ->
      # or: if a == b, do: 0, else: 1
      bxor(a, b)
    end)
  end

  def count_bits(0), do: 0
  def count_bits(n), do: (n &&& 1) + count_bits(n >>> 1)

  # def part_two(problem) do
  #   problem
  # end
end
