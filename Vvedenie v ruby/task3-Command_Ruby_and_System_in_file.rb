#======== Задание 3 ========
puts "Введите команду Ruby"
command_for_ruby = STDIN.gets.chomp
#вызов команды ruby
begin
  eval(command_for_ruby)
rescue 
  puts "Возникла ошибка"
end

puts "Введите команду ОС"
command_for_console_OS = STDIN.gets.chomp
#Вызов системной команды

system(command_for_console_OS)
