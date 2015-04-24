defmodule Mix.Tasks.SortFile do
  use Mix.Task
  @shortdoc "reads in a file of randomized numbers and outputs a sorted list"

  def run(_) do
    list = read_numbers([], :stdio)
    list = Enum.sort(list)
    Enum.each(list, fn (number) ->
      line = (number |> Integer.to_string) <> "\n"
      IO.binwrite(:stdio, line)
    end)
  end

  defp read_numbers(list, device) do
    case IO.read(device, :line) do
      :eof -> list
      line ->
        number = line |> String.rstrip |> String.to_integer
        read_numbers([number|list], device)
    end
  end
end
