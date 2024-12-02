defmodule Aoc do

  def out(mode) do
    {:ok, rawInput} = File.read("./input")
    serialList = String.split(rawInput, ["   ", "\n"])
    rightList = Enum.drop_every(serialList, 2)
    leftList = Enum.take_every(serialList, 2)
    rightSort = Enum.sort(rightList)
    leftSort = Enum.sort(leftList)

    if mode == "add" do
      Enum.sum(compareEl(0, length(rightSort), leftSort, rightSort, []))
    end
    if mode == "sim" do
      Enum.sum(compareSim(0, length(rightSort), leftSort, rightSort, []))
    end
  end

  def compareEl(index, max, first, second, acc) do
     case index do
       ^max ->
        acc
       x ->
        argL = Enum.at(first, index)
        argR = Enum.at(second, index)
        newAcc = acc ++ [abs(String.to_integer(argL) - String.to_integer(argR))]
        newIndex = index + 1
        compareEl(newIndex, max, first, second, newAcc)
      end
  end

  def compareSim(index, max, first, second, acc) do
    case index do
      ^max ->
       acc
      x ->
       argL = Enum.at(first, index)
       IO.inspect(argL)
       newAcc = acc ++ [String.to_integer(argL) * Enum.count(second, & &1 == argL)]
       newIndex = index + 1
       compareSim(newIndex, max, first, second, newAcc)
     end
 end

end
