vowels = 'aeoui'
result = ('a'..'z').each.with_index
                   .each_with_object({}) do |(symb, index), memo|
  memo[symb] = index + 1 if vowels.include?(symb)
end

p result
