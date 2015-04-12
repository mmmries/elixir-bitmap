defmodule Bitmap do
  use Bitwise

  @chunk_size 1024

  defstruct chunks: %{}

  def create, do: %Bitmap{}
  def create(list) do
    Enum.reduce(list, create, &( store(&2, &1) ))
  end

  def member?(%Bitmap{chunks: chunks}, number) do
    {address, binary} = address_and_binary(number)
    chunk = Dict.get(chunks, address, 0)
    (chunk &&& binary) > 0
  end

  def store(%Bitmap{chunks: chunks} = bitmap, number) do
    {address, binary} = address_and_binary(number)
    chunk = Dict.get(chunks, address, 0) ||| binary
    %Bitmap{bitmap | chunks: Dict.put(chunks, address, chunk)}
  end

  def to_number(address, which_bit) do
    (address * @chunk_size) + which_bit
  end

  defp address_and_binary(number) do
    address = div(number, @chunk_size)
    binary = (1 <<< rem(number, @chunk_size))
    {address, binary}
  end
end
