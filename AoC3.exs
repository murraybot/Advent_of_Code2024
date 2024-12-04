defmodule Aoc do

  def out do
    {:ok, rawInput} = File.read("./input3")
    saniList = String.split(rawInput, "don't()")
    head = Enum.at(saniList, 0)
    resanList = Enum.map(saniList, fn x -> sanitize(x) end)
    final = List.to_string(Enum.concat([head], resanList))
    baseList = Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)/, final)
    trimList = Enum.flat_map(baseList, fn x -> Regex.scan(~r/\(\d{1,3},\d{1,3}\)/, List.to_string(x)) end)
    parenList = Enum.map(trimList, fn x ->
      strings = List.to_string(x)
      max1 = String.length(strings)-2
      #IO.inspect(max1)
      String.slice(strings, 1,max1) end)

    splitList = Enum.map(parenList, fn x -> String.split(x, ",") end)
    resultList = Enum.map(splitList, fn x -> mul(x) end)
    Enum.sum(resultList)
  end

  def mul([a,b]) do
    String.to_integer(a) * String.to_integer(b)
  end

  def sanitize(inputString) do
    if String.contains?(inputString, "do()") do
      parts = String.split(inputString, "do()")
      IO.inspect(length(parts))
      tl(parts)
    else
      ""
    end
  end

end
