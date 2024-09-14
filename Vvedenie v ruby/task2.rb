#======== Задание 2 ========
#Переменная для имени пользователя, введёного пользователем как аргумент при запуске программы
name_of_user = ARGV[0]
#Создание строки с форматированием
str_hello = sprintf( "Hello, %s", name_of_user)
#Вывод фразы Hello, "Имя пользователя"
puts str_hello
#Вывод вопроса "Какой ваш любимый язык?"
puts "Какой ваш любимый язык?"
#Переменная в которую записывается любимый язык пользователя
favorite_language = STDIN.gets.chomp
#Сравнение введённого любимого языка с потенциальными ответами
if favorite_language == "Ruby" || favorite_language == "RUBY" || favorite_language == "ruby" || favorite_language == "руби" || favorite_language == "Руби" 
    then puts "Подлиза" 
elsif favorite_language == "Python" || favorite_language == "python"
    then puts "Хорош"
elsif favorite_language == "C++" || favorite_language == "С++" || favorite_language == "C#" || favorite_language == "С#" 
    then puts "Ладно"
else
    puts "Скоро будет Ruby"
end