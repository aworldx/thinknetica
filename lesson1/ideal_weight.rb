puts 'Задача - Идеальный вес'
puts 'Ваше имя:'
name = gets.chomp

puts 'Ваш рост:'
weight = gets.chomp.to_i

ideal_weight = weight - 110

if ideal_weight >= 0
  puts "#{name}, Ваш идеальный вес: #{ideal_weight} кг."
else
  puts "#{name}, Ваш вес уже оптимальный"
end
