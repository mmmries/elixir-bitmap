defmodule Bitmap do
  use Bitwise

  defstruct map: 0

  def create, do: %Bitmap{}
  def create(list) do
    Enum.reduce(list, create, &( store(&2, &1) ))
  end

  def store(%Bitmap{map: map} = bitmap, number) do
    binary = (1 <<< number)
    %Bitmap{bitmap | map: (map ||| binary)}
  end
end
