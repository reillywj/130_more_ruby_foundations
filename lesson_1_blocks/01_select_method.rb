# Assignment: Build a select method

def select(arr)
  output = []
  arr.each do |element|
    output << element if yield(element)
  end
  output
end


# Test code

array = [1, 2, 3, 4, 5]

a = select(array) { |num| num.odd? }      # => [1, 3, 5]
b = select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
c = select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true


p a
p b
p c