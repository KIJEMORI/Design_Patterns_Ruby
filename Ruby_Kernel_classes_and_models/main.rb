require_relative 'People'
require_relative 'Studend'
require_relative 'Student_short'
require_relative 'double_tree'
require_relative 'Student_list_txt'
require_relative 'Data_list_student_short'
require_relative 'Student_list_JSON'
require_relative 'Student_list_YAML'
require_relative 'Student_list'

#====================== MAIN ========================

txt = Student_list_txt.new()
json = Student_list_JSON.new()
yaml = Student_list_YAML.new()

read = Student_list.new("list_json_students.json", json)
students = read.read()
#Вывод всех данных о каждом студенте

students.each {|n| puts n}

puts('---------------')

# yaml.write_to_yaml(students)
# std = Student_short.new(student: Students[0])
# puts std
# std = Student_short.from_info(info: "Аврелий Майски Доводчик; phone: 88005553535")
# puts std

# students.each{|x| Double_tree.new(x)}

# puts Double_tree.sorted_students(Double_tree.start_with())

# students_short = []

# Students.each {|x| students_short << Student_short.new(student: x)}

# # students_short.each {|x| puts x}

# dlsh = Data_list_student_short.new(students_short)

# data = dlsh.get_data()
# p (dlsh.get_names)
