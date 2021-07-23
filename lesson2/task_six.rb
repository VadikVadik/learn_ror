basket = {}
final_price = 0

loop do
  puts "Введите наименование товара"
  product = gets.chomp
  break if product == "стоп"

  puts "Введите цену товара: #{product}"
  price = gets.chomp.to_f

  puts "Введите количество купленного товара: #{product}"
  amount = gets.chomp.to_f

  basket[product] = {price => amount}
end

puts basket

puts "Вы купили:"
basket.each do |product, price|
  final_product_price = (price.keys[0] * price[price.keys[0]]).round(2)
  final_price += final_product_price
  puts "#{product}, на сумму: #{final_product_price} руб."
end

puts "Общая сумма покупок: #{final_price} руб."
