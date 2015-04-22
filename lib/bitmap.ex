defmodule Bitmap do
  use Bitwise

  defstruct bits: ""

  def create, do: %Bitmap{}
  def create(list) do
    Enum.reduce(list, create, &( store(&2, &1) ))
  end

  def member?(%Bitmap{bits: bits}, number) do
    case bits do
      << _pre::size(number), 1::size(1), _suff::bitstring >> -> true
      _ -> false
    end
  end

  def store(%Bitmap{bits: bits} = bitmap, number) when bit_size(bits) <= number do
    padding = number - bit_size(bits)
    %Bitmap{bitmap | bits: << bits::bitstring , 0::size(padding), 1::size(1) >>}
  end
  def store(%Bitmap{bits: bits} = bitmap, number) do
    << prefix::bitstring-size(number), _bit::size(1), suffix::bitstring >> = bits
    %Bitmap{bitmap | bits: << prefix::bitstring, 1::size(1), suffix::bitstring >>}
  end
end
