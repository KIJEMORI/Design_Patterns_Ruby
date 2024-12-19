require_relative 'Student_list_txt'
require_relative 'Student_short'
require_relative 'Studend'
require 'json'

class Student_list_JSON

  def initialize(file)
    @file = file
  end

  #функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
  def read_from_json()
      #Массив для хранениыя строк из файла
      lines_from_file = []
      
      begin
        file = File.open(@file,"r")
      rescue => e
        puts 1
        puts e
      end

      text = file.read

      students = JSON.parse(text, symbolize_names: true).map{|data| Student.new(**data)}

      @array = students

      return students
  end
    
  #функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
  def write_to_json(list_students)
    
      begin
        file = File.open(@file,"w")
      rescue => e
        puts e
      end
    
      data = list_students.map{|x| x.to_h}
      file.write(JSON.pretty_generate(data))
      

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