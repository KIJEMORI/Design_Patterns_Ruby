require_relative 'class_Studend'

#====================== MAIN ========================

#Открытие файла с данными и чтение их в массив
lines_from_file = []
file = File.open("list_students.rb","r")

while !file.eof?
  lines_from_file  << file.readline
end

file.close

#Инициализация массива для элементов класса Student
Students = []

#Разбиение каждой строки из файла на элементы для заполнения элементов класса Student
for index in 0..lines_from_file.size-1 do
  #разбиение на каждый параметр с его значением
  array_of_date = lines_from_file[index].split(";")

  #ФИО обязательное для заполнения
  name = array_of_date[0]
  array_without_name = array_of_date-[name]
  
  #Массив для заполнения не обязательных данных студентов со структурой ["Тип данных", "данные", ...]
  stats = []
  for index in 0..array_without_name.size-1 do
    array_without_name[index].split(" ", 2).each{|x| stats<<x}
  end

  #Создание хэша для заполнения необязательных параметров при создание переменной типа Student
  hash = Hash[]
  
  if stats.size > 0 then
    index = 0
    while index < stats.size-1 do
      hash[stats[index].delete ":"] = stats[index+1]
      index+=2
    end
  end
  
  #переменная типа Student
  begin
    std = Student.new(name, hash)
  rescue => e
    puts e
  end
  #запись студента в массив
  Students << std
  
end
#Вывод всех данных о каждом студенте

Students.each {|n| puts n}