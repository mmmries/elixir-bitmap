defimpl Enumerable, for: Bitmap do
  use Bitwise

  def count(%Bitmap{chunks: chunks}) do
    count = chunks |> Dict.values |> Enum.map(&(count(&1,0))) |> Enum.reduce(0, &+/2)
    {:ok, count}
  end
  def count(0, acc), do: acc
  def count(chunk, acc) when is_integer(chunk) do
    case chunk &&& 1 do
      1 -> count(chunk >>> 1, acc + 1)
      0 -> count(chunk >>> 1, acc)
    end
  end

  def member?(bitmap, number), do: {:ok, Bitmap.member?(bitmap, number) }

  def reduce(_bitmap, {:halt, acc}, _reducer), do: {:halted, acc}
  def reduce(bitmap, {:suspend, acc}, reducer), do: {:suspended, acc, &reduce(bitmap, &1, reducer)}
  def reduce(%Bitmap{chunks: chunks}, acc, reducer) do
    {:cont, acc} = chunks |> Enum.reduce acc, fn({address, chunk}, acc) ->
      reduce({address,chunk,0}, acc, reducer)
    end
    {:done, acc}
  end
  def reduce({address, 0, _which_bit}, {:cont, acc}, _reducer), do: {:cont, acc}
  def reduce({address, chunk, which_bit}, {:cont, acc}, reducer) do
    case chunk &&& 1 do
      1 -> reduce({address,chunk>>>1,which_bit+1}, reducer.(Bitmap.to_number(address,which_bit),acc), reducer)
      0 -> reduce({address,chunk>>>1,which_bit+1}, {:cont, acc}, reducer)
    end
  end
end
