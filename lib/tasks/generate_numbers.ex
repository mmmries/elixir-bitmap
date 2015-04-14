defmodule Mix.Tasks.GenerateNumbers do
  use Mix.Task
  @shortdoc "generates 1MM random numbers and writes to STDOUT"

  def run(_) do
    generate(1_000_000, Bitmap.create)
  end

  defp generate(0, bitmap), do: nil
  defp generate(how_many_left, bitmap) do
    num = rand_number
    case Enum.member?(bitmap, num) do
      true -> generate(how_many_left, bitmap)
      false ->
        IO.puts num
        generate(how_many_left - 1, Bitmap.store(bitmap, num))
    end
  end

  defp rand_number, do: :random.uniform(900_000_0000) + 99_999_9999
end
