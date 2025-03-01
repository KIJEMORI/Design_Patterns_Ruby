require_relative 'Student_short'
require_relative 'Studend'
require_relative 'Student_list'
require_relative 'Data_storage_strategy'
require 'json'

class Student_list_JSON < Data_storage_strategy

  def initialize(file = nil)
    super(file)
  end

  #функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
  def from()
    text = @open_file.read 
    students = JSON.parse(text, symbolize_names: true).map{|data| Student.new(data)}
    return students
  end
    
  #функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
  def to(list_students)
    data = list_students.map{|x| x.to_h}
    @open_file.write(JSON.pretty_generate(data))
  end  
end