defmodule BitmapTest do
  use ExUnit.Case

  test "storing numbers" do
    bitmap = Bitmap.create
    bitmap = Bitmap.store(bitmap, 3)
    bitmap = Bitmap.store(bitmap, 5)
    %Bitmap{bits: bits} = bitmap
    assert bits == << 5::size(6) >>
  end

  test "it knows what numbers it contains" do
    bitmap = Bitmap.create([1,3,5])
    assert Enum.member?(bitmap, 0) == false
    assert Enum.member?(bitmap, 1) == true
    assert Enum.member?(bitmap, 2) == false
    assert Enum.member?(bitmap, 3) == true
    assert Enum.member?(bitmap, 4) == false
    assert Enum.member?(bitmap, 5) == true
  end

  test "it knows how many numbers it holds" do
    bitmap = Bitmap.create(5..10)
    assert Enum.count(bitmap) == Enum.count(5..10)
  end

  test "generating a sorted list" do
    bitmap = Bitmap.create([99,55,66,11,22,0])
    assert Enum.into(bitmap, []) == [0,11,22,55,66,99]
  end

  test "storing large numbers" do
    bitmap = Bitmap.create([801_555_1234, 801_555_1111])
    assert Enum.into(bitmap, []) == [801_555_1111, 801_555_1234]
  end
end
