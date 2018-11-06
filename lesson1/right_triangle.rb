puts 'Задача - Прямоугольный треугольник'
puts 'Введите длину стороны треугольника A:'
a = gets.chomp.to_f

puts 'Введите длину стороны треугольника B:'
b = gets.chomp.to_f

puts 'Введите длину стороны треугольника C:'
c = gets.chomp.to_f

sides = [a, b, c]
max = sides.max
min1, min2 = sides.min(2)

right = (min1**2 + min2**2 == max**2)
isosceles = (max == min1 || max == min2 || min1 == min2)
equilateral = (max == min1 && max == min2 && min1 == min2)

puts "Прямоугольный: #{right}, равнобедренный: #{isosceles},
      равносторонний: #{equilateral}"
