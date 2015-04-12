defmodule BitmapTest do
  use ExUnit.Case

  test "storing numbers" do
    bitmap = Bitmap.create
    bitmap = Bitmap.store(bitmap, 3)
    bitmap = Bitmap.store(bitmap, 5)
    assert bitmap == 0b101000
  end

  test "it knows what numbers it contains" do
    bitmap = Bitmap.create([1,3,5])
    assert Bitmap.include?(bitmap, 0) == false
    assert Bitmap.include?(bitmap, 1) == true
    assert Bitmap.include?(bitmap, 2) == false
    assert Bitmap.include?(bitmap, 3) == true
    assert Bitmap.include?(bitmap, 4) == false
    assert Bitmap.include?(bitmap, 5) == true
  end

  test "it knows how many numbers it holds" do
    bitmap = Bitmap.create(5..10)
    assert Bitmap.size(bitmap) == Enum.count(5..10)
  end

  test "generating a sorted list" do
    bitmap = Bitmap.create([99,55,66,11,22,0])
    assert Bitmap.to_list(bitmap) == [0,11,22,55,66,99]
  end
end
