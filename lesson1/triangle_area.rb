puts "Введите основание треугольника"
base = gets.chomp
puts base
puts "Введите высоту треугольника"
height = gets.chomp
puts height
area = (0.5 * base.to_i) * height.to_i
puts area
puts "Площадь треугольника: #{area}"
