basket = {}

loop do
  puts 'Введите название товара'
  product_name = gets.chomp

  break if product_name == 'стоп'

  puts 'Введите цену за единицу товара'
  price = gets.chomp.to_f

  puts 'Введите количество купленного товара'
  count = gets.chomp.to_f

  basket[product_name] = { price: price, count: count }
end

if basket.empty?
  puts 'В корзине нет товаров!'
else
  puts basket
end

total = 0
basket.each do |product_name, purchase|
  worth = purchase[:count] * purchase[:price]

  print "Товар: #{product_name}, Количество: #{purchase[:count]}"
  puts " Цена: #{purchase[:price]}, Сумма: #{worth}"

  total += worth
end

puts "Итого: #{total}"
