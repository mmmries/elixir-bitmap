defimpl Enumerable, for: Integer do
  use Bitwise

  def count(bitmap), do: {:ok, count(bitmap, 0)}
  def count(0, acc), do: acc
  def count(bitmap, acc) do
    case bitmap &&& 1 do
      1 -> count(bitmap >>> 1, acc + 1)
      0 -> count(bitmap >>> 1, acc)
    end
  end

  def member?(bitmap, number) do
    binary = 1 <<< number
    {:ok, (bitmap &&& binary) > 0}
  end

  def reduce(_bitmap, {:halt, acc}, _reducer), do: {:halted, acc}
  def reduce(bitmap, {:suspend, acc}, reducer), do: {:suspended, acc, &reduce(bitmap, &1, reducer)}
  def reduce(bitmap, {:cont, acc}, reducer) when is_integer(bitmap) do
    reduce({bitmap,0}, {:cont, acc}, reducer)
  end
  def reduce({0,_which_bit}, {:cont, acc}, _reducer), do: {:done, acc}
  def reduce({bitmap, which_bit}, {:cont, acc}, reducer) do
    case bitmap &&& 1 do
      1 -> reduce({bitmap>>>1,which_bit+1}, reducer.(which_bit,acc), reducer)
      0 -> reduce({bitmap>>>1,which_bit+1}, {:cont, acc}, reducer)
    end
  end
end
