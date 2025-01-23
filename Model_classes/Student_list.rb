require_relative 'Student_short'
require_relative 'Studend'
require_relative 'Data_list_student_short'

class Student_list

  def initialize(data_storage_strategy)
    self.data_storage_strategy = data_storage_strategy
  end

  def data_storage_strategy= (data_storage_strategy)
    @data_storage_strategy = data_storage_strategy
  end



  #функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
  def read()
    @data_storage_strategy.open()
    @array = @data_storage_strategy.from()
    @data_storage_strategy.close()

    return @array
  end

  #функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
  def write(list_students)
    @data_storage_strategy.open()

    @data_storage_strategy.to(list_students)

    @data_storage_strategy.close()
  end  

  def search_on_id(number)
    return @array.select(){|x| x.id == number}
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    read = read()

    raise "Нет такого количества объктов n" if n > @array.size()
    
    qty = (@array.size()/n).to_i

    raise "Нет такого количества страниц" if k > qty

    students_short = []

    for index in 0...n
      item = @array[k*n + index]

      if (item) 
        std = Student_short.new(student: item, id: item.id) 
      else 
        next
      end
      # std.id = index

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