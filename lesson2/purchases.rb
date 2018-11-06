basket = {}

loop do
  puts 'Введите название товара'
  product_name = gets.chomp

  break if product_name == 'стоп'

  puts 'Введите цену за единицу товара'
  price = gets.chomp.to_f

  puts 'Введите количество купленного товара'
  count = gets.chomp.to_f

  basket[product_name] = { price: price, count: count, worth: price * count }
end

if basket.empty?
  p 'В корзине нет товаров!'
else
  p basket
end

total = basket.inject(0) { |memo, (_, numbers)| memo + numbers[:worth] }
p total
