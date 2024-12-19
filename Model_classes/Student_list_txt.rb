require_relative 'Student_list_txt'
require_relative 'Student_short'
require_relative 'Studend'

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

class Student_list_txt

  def initialize(file)
    @file = file
  end

  #функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
  def read_from_txt()
      #Массив для хранениыя строк из файла
      lines_from_file = []
      
      begin
        file = File.open(@file,"r")
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
      for index in 0...lines_from_file.size do
        
        #переменная типа Student
        begin
          std = lines_from_file[index].to_Student(index)

          students << std
        rescue => e
          puts e
        end
        #запись студента в массив
        
      end

      @array = students
      
      return students
  end
    
  #функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
  def write_to_txt(list_students)
    
      begin
        file = File.open(@file,"w")
      rescue => e
        puts e
      end
    
      for index in 0..list_students.size
        file << list_students[index].to_s + "\n"
      end
      file.close
  end  

  def search_on_id(number)
    return @array.select(){|x| x.id == number}
  end

  def get_k_n_student_short_list(k, n, data_list = nil)

    raise "Нет такого количества объктов n" if n > @array.size()
    
    qty = (@array.size()/n).to_i

    raise "Нет такого количества страниц" if k > qty

    students_short = []
    for index in 0...n
      item = @array[(k-1)*n + index]
      if (item != nil) 
        std = Student_short.new(item) 
      else 
        next
      end
      std.id = index
      students_short << std
    end

    return Data_list_student_short.new(students_short)

  end

  def sort_by_lastname_and_initals()
    @array.sort_by{|x| x.last_name_and_initials}
  end

  def add_student(student)
    max_id = @array.max_by{|x| x.id}
    id = 0
    id = max_id 1 if !max_id
    
    student.id = id
    @array << student
  end

  def replace_student_by_id(id, student)

    @array.select{|x| x.id == id}.map{|x| x = student} 

  end

  def delete_student_by_id(id)
    @array.delete_if{|x| x.id == id}
  end

  def get_student_short_count()
    @array.size()
  end

end