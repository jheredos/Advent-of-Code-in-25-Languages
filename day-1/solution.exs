defmodule Solution do
  def part_1 do
    read_input()
    |> String.split("\n\n")
    |> Enum.map(fn n -> total(n) end)
    |> Enum.max()
  end

  def part_2 do
    read_input()
    |> String.split("\n\n")
    |> Enum.map(fn n -> total(n) end)
    |> top_3()
    |> Enum.sum()
  end

  def read_input do
    case File.read("input.txt") do
      {:ok, s} -> s
      {:error, _} -> ""
    end
  end

  def parse(s) do
    String.split(s, "\n")
    |> Enum.map(fn n ->
      case Integer.parse(n) do
        {x, _} -> x
        :error -> 0
      end
    end)
  end

  def total(s) do
    parse(s)
    |> Enum.sum()
  end

  def top_3(xs) do
    sorted = Enum.sort(xs) |> Enum.reverse()
    [a,b,c | _] = sorted
    [a,b,c]
  end
end

Solution.part_1()
|> IO.puts

Solution.part_2()
|> IO.puts
