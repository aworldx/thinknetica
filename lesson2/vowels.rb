vowels = 'aeoui'
result = ('a'..'z').each.with_index(1)
                   .each_with_object({}) do |(symb, index), memo|
  memo[symb] = index if vowels.include?(symb)
end

puts result
