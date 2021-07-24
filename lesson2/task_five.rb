year = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}
leap_year = {1 => 31, 2 => 29, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}

puts "Введите день"
user_day = gets.chomp.to_i
puts "Введите месяц"
user_month = gets.chomp.to_i
puts "Введите год"
user_year = gets.chomp.to_i

date_number = 0

if (user_year % 4 == 0 && user_year % 100 != 0) || user_year == 2000
  year[2] = 29
end

user_month -= 1
while user_month > 0 do
  date_number += year[user_month]
  user_month -= 1
end

date_number += user_day

puts "Порядковый номер вашей даты: #{date_number}"
