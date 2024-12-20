
require_relative 'Student_short'
require_relative 'Studend'
require_relative 'Student_list'

class String
  #Функция класса String для создания переменной класса Student из строки
    def to_Student(id = nil, string_full_info = self)
      
      validate_string = string_full_info.gsub(" ","")
      raise "Строка не должна быть пустой" if (validate_string == "")
  
      #разбиение на каждый параметр с его значением
      array_of_date = string_full_info.split(";")
  
      #ФИО обязательное для заполнения
      name = array_of_date[0].downcase
      
      array_without_name = array_of_date[1..]
      
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
      
      
      hash[:id] = id
      hash[:last_name] = fio[0]
      hash[:first_name] = fio[1]
      hash[:surname] = fio[2]
      hash = hash.transform_keys(&:to_sym)
      
      return Student.new(hash)
    end
end

class Student_list_txt < Student_list

  def initialize(file)
    super(file)
  end

  #функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
  def from(file)

      #Массив для хранениыя строк из файла
      lines_from_file = []

      while !file.eof?
        lines_from_file  << file.readline.chomp
      end

      #Инициализация массива для элементов класса Student
      students = []
      #Разбиение каждой строки из файла на элементы для заполнения элементов класса Student
      for index in 0...lines_from_file.size do  
        #переменная типа Student
        begin
          std = lines_from_file[index].to_Student(index)
          students << std
        rescue => e
          puts e
        end
      end

      @array = students
      
      return students
  end
    
  #функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
  def to(list_students, file)
    
      for index in 0..list_students.size
        file << list_students[index].to_s + "\n"
      end

  end  

end