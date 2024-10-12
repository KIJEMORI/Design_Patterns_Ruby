require_relative 'class_Studend'

#====================== MAIN ========================

Students = read_from_txt("list_students.rb")
#Вывод всех данных о каждом студенте

Students.each {|n| puts n}

std = Student_short.new(student: Students[0])
puts std
std = Student_short.new(info: "Аврелий Майски Доводчик; phone: 88005553535")
puts std

