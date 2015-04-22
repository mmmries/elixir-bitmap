defimpl Enumerable, for: Bitmap do
  use Bitwise

  def count(%Bitmap{bits: bits}) do
    {:ok, count(bits, 0)}
  end
  def count(<< >>, acc), do: acc
  def count(<<1::size(1), rest::bitstring>>, acc), do: count(rest, acc+1)
  def count(<<0::size(1), rest::bitstring>>, acc), do: count(rest, acc)

  def member?(bitmap, number), do: {:ok, Bitmap.member?(bitmap, number) }

  def reduce(_bitmap, {:halt, acc}, _reducer), do: {:halted, acc}
  def reduce(bitmap, {:suspend, acc}, reducer), do: {:suspended, acc, &reduce(bitmap, &1, reducer)}
  def reduce(%Bitmap{bits: bits}, acc, reducer) do
    reduce({bits,0}, acc, reducer)
  end
  def reduce({<< >>,_which_bit}, {:cont,acc}, _reducer), do: {:done, acc}
  def reduce({<<0::size(262_144), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+262_144}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(65_536), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+65_536}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(16_384), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+16_384}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(4096), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+4096}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(1024), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+1024}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(256), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+256}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(64), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+64}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(16), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+16}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(4), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+4}, {:cont, acc}, reducer)
  end
  def reduce({<<0::size(1), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+1}, {:cont, acc}, reducer)
  end
  def reduce({<<1::size(1), rest::bitstring>>, which_bit}, {:cont,acc}, reducer) do
    reduce({rest,which_bit+1}, reducer.(which_bit, acc), reducer)
  end
end
