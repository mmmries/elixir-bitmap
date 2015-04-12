defmodule Bitmap do
  use Bitwise

  def create, do: 0
  def create(list) do
    Enum.reduce(list, create, &( store(&2, &1) ))
  end

  def store(bitmap, number) do
    binary = (1 <<< number)
    bitmap ||| binary
  end
end
