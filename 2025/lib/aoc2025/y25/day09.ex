defmodule Aoc2025.Y25.Day09 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.stream!(trim: true)
    |> Enum.map(fn line ->
      [x, y] = String.split(line, ",")
      {String.to_integer(x), String.to_integer(y)}
    end)
  end

  def part_one(coords) do
    coords
    |> generate_all_pairs()
    |> Enum.map(fn {{x1, y1}, {x2, y2}} ->
      (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
    end)
    |> Enum.max()
  end

  defp generate_all_pairs(list) do
    indexed = Enum.with_index(list)
    for {a, i} <- indexed, {b, j} <- indexed, i < j, do: {a, b}
  end

  #ALL AI BELOW, this was so hard
  #I spent enough time and gave up
  #COME BACK LATER and see wtf is happening
  def part_two(coords) do
    segments = build_segments(coords)
    vertical_edges = Enum.filter(segments, fn {type, _, _, _} -> type == :vertical end)

    coords
    |> generate_all_pairs()
    |> Enum.filter(fn {corner1, corner2} ->
      rectangle_valid?(corner1, corner2, segments, vertical_edges)
    end)
    |> Enum.map(fn {{x1, y1}, {x2, y2}} ->
      (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
    end)
    |> Enum.max(fn -> 0 end)
  end

  # Build segments: {:vertical, x, y_min, y_max} or {:horizontal, y, x_min, x_max}
  defp build_segments(coords) do
    coords
    |> Enum.chunk_every(2, 1, [hd(coords)])
    |> Enum.map(fn [{x1, y1}, {x2, y2}] ->
      if x1 == x2 do
        {:vertical, x1, min(y1, y2), max(y1, y2)}
      else
        {:horizontal, y1, min(x1, x2), max(x1, x2)}
      end
    end)
  end

  defp rectangle_valid?({x1, y1}, {x2, y2}, segments, vertical_edges) do
    min_x = min(x1, x2)
    max_x = max(x1, x2)
    min_y = min(y1, y2)
    max_y = max(y1, y2)

    # No boundary segment crosses through the INTERIOR
    no_interior_crossing =
      Enum.all?(segments, fn segment ->
        not crosses_interior?(segment, min_x, max_x, min_y, max_y)
      end)

    # Center must be inside the polygon
    center_x = div(min_x + max_x, 2)
    center_y = div(min_y + max_y, 2)
    center_inside = inside_polygon?({center_x, center_y}, vertical_edges)

    no_interior_crossing and center_inside
  end

  # Does segment cross through the INTERIOR? (touching edge doesn't count)
  defp crosses_interior?(segment, min_x, max_x, min_y, max_y) do
    case segment do
      {:vertical, x, y1, y2} ->
        # x must be strictly inside, AND y range must strictly overlap interior
        x > min_x and x < max_x and y1 < max_y and y2 > min_y

      {:horizontal, y, x1, x2} ->
        # y must be strictly inside, AND x range must strictly overlap interior
        y > min_y and y < max_y and x1 < max_x and x2 > min_x
    end
  end

  # Ray casting: count vertical edge crossings to the right
  defp inside_polygon?({px, py}, vertical_edges) do
    crossings =
      Enum.count(vertical_edges, fn {:vertical, x, y_min, y_max} ->
        x > px and y_min <= py and py <= y_max
      end)

    rem(crossings, 2) == 1
  end
end
