puts "Как Вас зовут?"
name = gets.chomp

puts "Какой у Вас рост?"
height = gets.chomp

weight = (height.to_i - 110) * 1.15

if weight > 0
  puts "#{name}, ваш идеальный вес: #{weight}"
else
  puts "Ваш вес уже оптимальный."
end
