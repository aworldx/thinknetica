arr = (10..100).each_with_object([]) do |number, memo|
  memo << number if (number % 5).zero?
end

puts arr
