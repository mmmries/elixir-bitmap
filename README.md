Bitmap
======

[Bitmaps](http://en.wikipedia.org/wiki/Bitmap) are a datastructure where you store a series of true/false values in a series of bits. For instance if you had a set of numbers `[2,5,8]` you could represent that whole set as an Array containing 3 8-bit numbers, or you could store them as a single 9-bit number `0b100100100`.

This is a dense way of representing a set of values as long as you can easily map the bits to and from the domain of values you are interested in. For an example of where they are useful see [Cracking The Oyster](http://www.cs.bell-labs.com/cm/cs/pearls/sec014.html) from the [Programming Pearls](http://www.cs.bell-labs.com/cm/cs/pearls/) book.


How to Use It
-------------
```elixir
bitmap = Bitmap.create([8,4,9,1,5])
Enum.member?(bitmap, 4) # => true
Enum.member?(bitmap, 6) # => false
Enum.count(bitmap) # => 5
Enum.into(bitmap, []) # => [1,4,5,8,9]
Enum.each(bitmap, &( IO.puts(&1) ))
# => 1
# => 4
# => 5
# => 8
# => 9
```
