# Assignment: Build a 'reduce' method

# similar to Array#reduce
# accumulate or fold a collection into 1 object

def reduce(arr, accum = 0)
  arr.each do |element|
    accum = yield(accum, element)
  end
  accum
end