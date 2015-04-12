defimpl Enumerable, for: Bitmap do
  use Bitwise

  def count(%Bitmap{map: map}), do: {:ok, count(map, 0)}
  def count(0, acc), do: acc
  def count(map, acc) when is_integer(map) do
    case map &&& 1 do
      1 -> count(map >>> 1, acc + 1)
      0 -> count(map >>> 1, acc)
    end
  end

  def member?(%Bitmap{map: map}, number) do
    binary = 1 <<< number
    {:ok, (map &&& binary) > 0}
  end

  def reduce(_bitmap, {:halt, acc}, _reducer), do: {:halted, acc}
  def reduce(bitmap, {:suspend, acc}, reducer), do: {:suspended, acc, &reduce(bitmap, &1, reducer)}
  def reduce(%Bitmap{map: map}, {:cont, acc}, reducer) do
    reduce({map,0}, {:cont, acc}, reducer)
  end
  def reduce({0,_which_bit}, {:cont, acc}, _reducer), do: {:done, acc}
  def reduce({map, which_bit}, {:cont, acc}, reducer) do
    case map &&& 1 do
      1 -> reduce({map>>>1,which_bit+1}, reducer.(which_bit,acc), reducer)
      0 -> reduce({map>>>1,which_bit+1}, {:cont, acc}, reducer)
    end
  end
end
