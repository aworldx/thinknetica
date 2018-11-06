puts 'Введите число:'
day = gets.chomp.to_i

puts 'Введите месяц:'
month = gets.chomp.to_i

puts 'Введите год:'
year = gets.chomp.to_i

leap = ((year % 4).zero? && (year % 100 != 0 || (year % 400).zero?))
days = [31, leap ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

day_index = (1..month).inject(0) do |memo, index|
  memo + (index == month ? day : days[index + 1])
end

p day_index
