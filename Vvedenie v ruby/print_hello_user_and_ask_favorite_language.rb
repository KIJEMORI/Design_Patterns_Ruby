#======== Задание 2 ========

# Проверяем задали ли имя пользователя
if ARGV.length == 0
	puts("Пожалуйста, укажите ваше имя")
	# Завершаем программу
	exit
end

#Переменная для имени пользователя, введёного пользователем как аргумент при запуске программы
name_of_user = ARGV[0]

#Создание строки с форматированием
str_hello = sprintf( "Hello, %s", name_of_user)
#Вывод фразы Hello, "Имя пользователя"
puts str_hello
puts "-------------------"

puts "Какой ваш любимый язык?"
#Переменная в которую записывается любимый язык пользователя
favorite_language = STDIN.gets.chomp.downcase
#Сравнение введённого любимого языка с потенциальными ответами
if favorite_language == "ruby" || favorite_language == "руби" 
    then puts "Подлиза" 
elsif favorite_language == "python" || favorite_language == "питон"
    then puts "Хорош"
elsif favorite_language == "c++" || favorite_language == "с++" || favorite_language == "c#" || favorite_language == "с#" 
    then puts "Ладно"
else
    puts "Скоро будет Ruby"
end
