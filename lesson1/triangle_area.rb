puts 'Задача - Площадь треугольника'
puts 'Введите основание треугольника:'
triangle_base = gets.chomp.to_f

puts 'Введите высоту треугольника:'
triangle_height = gets.chomp.to_f

area = triangle_base * triangle_height * 0.5
puts "Площадь треугольника: #{area}"
