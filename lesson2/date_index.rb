puts 'Введите число:'
day = gets.chomp.to_i

puts 'Введите месяц:'
month = gets.chomp.to_i

puts 'Введите год:'
year = gets.chomp.to_i

leap = ((year % 4).zero? && (year % 100 != 0 || (year % 400).zero?))

day_index = (1..month).inject(0) do |memo, index|
  days_count = if index == 2
                 leap ? 29 : 28
               else
                 index.odd? ? 31 : 30
               end

  memo + (index == month ? day : days_count)
end

p day_index
