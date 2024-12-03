defmodule Aoc do

  def out do
    {:ok, rawInput} = File.read("./input2")
    serialList = String.split(rawInput, "\n")
    subList = Enum.map(serialList, fn x -> String.split(x, " ") end)
    finalList = Enum.map(subList, fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    checks = Enum.map(finalList, fn x -> safetyCheck(x) end)
    checked = Enum.map(checks, fn x ->
      if x == true do
        true
      else
        dampen(x)
      end
      end)

    Enum.count(checked, & &1 == true)
  end

  def safetyCheck(levels) do
    start = Enum.at(levels, 0)
    second = Enum.at(levels, 1)
    asc = start < second
    if abs(start - second) > 3 || abs(start - second) < 1 do
      levels
    else
      safetyCheck(levels, length(levels), 1, asc)
    end
  end

  def safetyCheck(levels, max, index, asc) do
    curr = Enum.at(levels, index)
    next = Enum.at(levels, index + 1)

    cond do
      asc !== curr < next ->
        levels
      abs(curr - next) > 3 || abs(curr - next) < 1 ->
        levels
      max == index + 2 ->
        true
      true ->
        safetyCheck(levels, length(levels), index+1, asc)
    end

  end

  def dampen(levels) do
    newLevels = List.delete_at(levels, 0)
    if safetyCheck(newLevels) === true do
      IO.inspect(newLevels)
      true
    else
      dampen(levels, length(levels), 1)
    end
  end

  def dampen(levels, max, index) do
    newLevels = List.delete_at(levels, index)

    cond do
      safetyCheck(newLevels) === true->
        IO.inspect(newLevels)
        true
      max == index + 1 ->
        false
      true ->
        dampen(levels, length(levels), index + 1)
    end
  end

end
