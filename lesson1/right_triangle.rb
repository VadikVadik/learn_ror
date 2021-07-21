puts "Введите 1 сторону треугольника"
first_side = gets.chomp.to_f

puts "Введите 2 сторону треугольника"
second_side = gets.chomp.to_f

puts "Введите 3 сторону треугольника"
third_side = gets.chomp.to_f

if first_side == second_side && second_side == third_side
  puts "Треугольник равносторонний!"
elsif first_side == second_side || second_side == third_side || third_side == first_side
  isosceles = true
end

if first_side > second_side && first_side > third_side
  if (first_side**2).round == ((second_side**2).round + (third_side**2).round)
    right = true
  else
    right = false
  end
elsif second_side > first_side && second_side > third_side
  if (second_side**2).round == ((first_side**2).round + (third_side**2).round)
    right = true
  else
    right = false
  end
elsif third_side > first_side && third_side > second_side
  if (third_side**2).round == ((second_side**2).round + (first_side**2).round)
    right = true
  else
    right = false
  end
end

if isosceles && right
  puts "Треугольник равнобедренный и прямоугольный"
elsif isosceles && !right
  puts "Треугольник равнобедренный"
elsif !isosceles && right
  puts "Треугольник прямоугольный"
else
  puts "Обыкновенный треугольник"
end
