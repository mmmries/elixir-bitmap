defmodule Bitmap do
  use Bitwise

  def create, do: 0
  def create(list) do
    Enum.reduce(list, create, &( store(&2, &1) ))
  end

  def include?(bitmap, number) do
    binary = (1 <<< number)
    (bitmap &&& binary) > 0
  end

  def size(bitmap), do: size(bitmap, 0)
  def size(0, acc), do: acc
  def size(bitmap, acc) do
    case bitmap &&& 1 do
      1 -> size(bitmap >>> 1, acc + 1)
      0 -> size(bitmap >>> 1, acc)
    end
  end

  def store(bitmap, number) do
    binary = (1 <<< number)
    bitmap ||| binary
  end

  def to_list(bitmap), do: to_list(bitmap, 0, [])
  def to_list(0, _which_bit, list), do: Enum.reverse(list)
  def to_list(bitmap, which_bit, list) do
    case bitmap &&& 1 do
      1 -> to_list(bitmap >>> 1, which_bit + 1, [which_bit | list])
      0 -> to_list(bitmap >>> 1, which_bit + 1, list)
    end
  end
end
