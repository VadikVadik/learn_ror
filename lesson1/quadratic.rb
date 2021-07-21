puts "Введите коэффициент А"
a = gets.chomp.to_f

puts "Введите коэффициент B"
b = gets.chomp.to_f

puts "Введите коэффициент C"
c = gets.chomp.to_f

d = b**2 - (4*a*c)

if d > 0
  sqrt = Math.sqrt(d)
  x1 = (-b + sqrt) / (a * 2)
  x2 = (-b - sqrt) / (a * 2)
  puts "Дискриминант: #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x1 = -b / (a * 2)
  puts "Дискриминант: #{d}, x = #{x1}"
else
  puts "Дискриминант: #{d}, корней нет"
end
