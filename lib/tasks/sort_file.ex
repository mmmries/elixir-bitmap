defmodule Mix.Tasks.SortFile do
  use Mix.Task
  @shortdoc "reads in a file of randomized numbers and outputs a sorted list"

  def run(_) do
    bitmap = read_numbers(Bitmap.create, :stdio)
    Enum.each(bitmap, fn (number) ->
      line = (number |> Integer.to_string) <> "\n"
      IO.binwrite(:stdio, line)
    end)
  end

  defp read_numbers(bitmap, device) do
    case IO.read(device, :line) do
      :eof -> bitmap
      line ->
        number = line |> String.rstrip |> String.to_integer
        bitmap = bitmap |> Bitmap.store(number)
        read_numbers(bitmap, device)
    end
  end
end
