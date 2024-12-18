require_relative 'People'
require_relative 'Studend'
require_relative 'Student_short'
require_relative 'double_tree'
require_relative 'Data_list_student_short'

class String
  #Функция класса String для создания переменной класса Student из строки
    def to_Student(string_full_info = self)
      
      validate_string = string_full_info.gsub(" ","")
      raise "Строка не должна быть пустой" if (validate_string == "")
  
      #разбиение на каждый параметр с его значением
      array_of_date = string_full_info.split(";")
  
      #ФИО обязательное для заполнения
      name = array_of_date[0].downcase
      array_without_name = array_of_date-[name]
      #разделение фио на разные параметры и запись в массив для дальнейшего извлечения в конструктор
      fio = name.split(" ")
  
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
          hash[stats[index].downcase.delete":"] = stats[index+1]
          index+=2
        end
      end
      
      hash[:last_name] = fio[0]
      hash[:first_name] = fio[1]
      hash[:surname] = fio[2]

      return Student.new(hash)
    end
  end
  
#функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
def read_from_txt(file)
    #Массив для хранениыя строк из файла
    lines_from_file = []
    
    begin
      file = File.open(file,"r")
    rescue => e
      puts e
    end
  
    while !file.eof?
      lines_from_file  << file.readline.chomp
    end
  
    file.close
  
    #Инициализация массива для элементов класса Student
    students = []
  
    #Разбиение каждой строки из файла на элементы для заполнения элементов класса Student
    for index in 0..lines_from_file.size-1 do
      
      #переменная типа Student
      begin
        std = lines_from_file[index].to_Student
      rescue => e
        puts e
      end
      #запись студента в массив
      students << std
      
    end
    return students
end
  
#функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
def write_to_txt(file, list_students)
  
    begin
      file = File.open(file,"w")
    rescue => e
      puts e
    end
  
    for index in 0..list_students.size
      file << list_students[index].to_s + "\n"
    end
    file.close
end  

#====================== MAIN ========================

Students = read_from_txt("list_students.rb")
#Вывод всех данных о каждом студенте

Students.each {|n| puts n}

puts('---------------')

# std = Student_short.new(student: Students[0])
# puts std
# std = Student_short.from_info(info: "Аврелий Майски Доводчик; phone: 88005553535")
# puts std

# Students.each{|x| Double_tree.new(x)}

# puts Double_tree.sorted_students(Double_tree.start_with())

students_short = []

Students.each {|x| students_short << Student_short.new(student: x)}

# students_short.each {|x| puts x}

dlsh = Data_list_student_short.new(students_short)

data = dlsh.get_data()
p (dlsh.get_names)
