
# implement own each
def my_each(iterator)
  index = 0
  while index < iterator.size
    yield(iterator[index], index) if block_given?
    index += 1
  end
  iterator
end

# implement own select
def my_select(iterator)
  return_array = []
  my_each(iterator) do |val, index|
    return_array << val if yield(val, index)
  end
  return_array
end

# own reduce
def my_reduce(iterator, accum_val = 0)
  accumulated_value = accum_val
  my_each(iterator) do |val|
    accumulated_value = yield(accumulated_value, val)
  end
  accumulated_value
end

# own map
def my_map(iterator)
  mapped_array = []
  my_each(iterator) do |val, index|
    mapped_array << yield(val, index)
  end
  mapped_array
end



a = (1..10).to_a
my_each(a) { |val, index| puts "iterator: #{val} at index #{index}" }

b = my_select(a) do |_, index|
  index.even?
end
p b

c = my_select(a) do |val|
  val > 5
end

p c

d = my_reduce(c) {|accum, val| accum + val}
puts d

e = my_map(a) {|val| val / 10.0 }
p e