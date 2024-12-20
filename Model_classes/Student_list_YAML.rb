require_relative 'Student_short'
require_relative 'Studend'
require_relative 'Student_list'
require 'yaml'

class Student_list_YAML < Student_list

  def initialize(file)
    super(file)
  end

  #функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
  def from(file)

      text = file.read

      students = YAML.safe_load(text, permitted_classes: [Data, Symbol]).map{|data| Student.new(**data)}

      @array = students

      return students
      
  end
    
  #функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
  def to(list_students, file)
    
      data = list_students.map{|x| x.to_h}
      file.write(data.to_yaml)

  end  

  

end