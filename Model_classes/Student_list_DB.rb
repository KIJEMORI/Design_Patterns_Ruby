
require_relative 'Student_short'
require_relative 'Studend'
require_relative 'Student_list'
require_relative 'Data_storage_strategy'
require_relative '../DB/DB'


class Student_list_DB

  def initialize (user, pass, database)
    self.user = user
    self.pass = pass
    self.database = database
    open()
  end



  attr_accessor :user, :pass, :database

  def open()
    DB.instance(@user, @pass, @database)
  end

  # В некоторых БД требуется разорвать соединение но в Postgrqsql не требуется
  def close()

  end

  def select ( parameters_select = {id: nil, last_name: nil, first_name: nil, surname: nil, github: nil, phone: nil, mail: nil, telegram: nil, limit: nil, offset: nil, sort_column: nil, sort: "ASC"})

    command = 'select * from STUDENT'

    where = ' where '
    where += "id = #{parameters_select[:id]}" if parameters_select[:id]
    where += "last_name = #{parameters_select[:last_name]}" if parameters_select[:last_name]
    where += "first_name = #{parameters_select[:first_name]}" if parameters_select[:first_name]
    where += "surname = #{parameters_select[:surname]}" if parameters_select[:surname]
    where += "github = #{parameters_select[:github]}" if parameters_select[:github]
    where += "phone = #{parameters_select[:phone]}" if parameters_select[:phone]
    where += "mail = #{parameters_select[:mail]}" if parameters_select[:mail]
    where += "telegram = #{parameters_select[:telegram]}" if parameters_select[:telegram]
    

    if where != " where "
      command += where 
    end

    command += " order by #{parameters_select[:sort_column]} #{parameters_select[:sort]}" if parameters_select[:sort_column]

    command += " limit #{parameters_select[:limit]} " if parameters_select[:limit]
    command += " offset #{parameters_select[:offset]} " if parameters_select[:offset]

    return parse_select(DB.instance.select_from_table(command))
  end

  def into_table_student(student)

    command = ""
    
    command +=  "insert into student "
    command +=  "(id, last_name, first_name, surname, github, phone, mail, telegram) "
    command +=  "values "

    id = student.id
    last_name = "'#{student.last_name}'"
    first_name = "'#{student.first_name}'"
    surname = "'#{student.surname}'" if student.surname
    surname = "null" if !student.surname
    github = "'#{student.github}'" if student.github
    github = "null" if !student.github
    phone = "'#{student.phone}'" if student.phone
    phone = "null" if !student.phone
    mail = "'#{student.mail}'" if student.mail
    mail = "null" if !student.mail
    telegram = "'#{student.telegram}'" if student.telegram
    telegram = "null" if !student.telegram

    command +=  "(#{id}, #{last_name}, #{first_name}, #{surname}, #{github}, #{phone}, #{mail}, #{telegram})"
    
    DB.instance.command_into_table(command)
  end

  def create_table()
    command = "
    create table Student
    (
      id INT,
      last_name text,
      first_name text,
      surname text,
      github text,
      phone text,
      mail text,
      telegram text
    )
    "

    DB.instance.create_table(command)
  end

  def drop_table()
    command = 'drop table Student'
    DB.instance.drop_table(command)
  end

  attr_accessor :array

  def search_on_id(number)
    command = "select * from student where id = #{id}"
    return parse_select(DB.instance.select_from_table(command))
  end
  
  def get_k_n_student_short_list(k, n, parameters_select = {id: nil, last_name: nil, first_name: nil, surname: nil, github: nil, phone: nil, mail: nil, telegram: nil, sort_column: nil, sort: "ASC" }, data_list = nil)

    parameters_select[:limit] = n
    parameters_select[:offset] = k*n
    p parameters_select
    array = select(parameters_select)
    return array
  
  end
  
  def add_student(student)
    max_id = @array.max_by{|x| x.id}
    id = 0
    id = max_id 1 if !max_id
    
    student.id = id
    into_table_student(student)

    @array << student
  end
  
  def replace_student_by_id(id, student)
    command = "update student set () values () where id = #{id}"
    DB.instance.command_into_table(command)
    # @array.select{|x| x.id == id}.map{|x| x = student} 
  end
  
  def delete_student_by_id(id)
    command = "delete from student where id = #{id}"
    DB.instance.command_into_table(command)
    # @array.delete_if{|x| x.id == id}
  end
  
  def get_student_short_count()
    command = "Select count(*) from student"
    return DB.instance.select_from_table(command)
  end

  def from()
    return select()
  end

  def to(list_students)
    list_students.each do |student|
      into_table_student(student)
    end
  end
  
  private
  def parse_select(array)
    students = []

    array.each do |x|
      x = Hash(x).transform_keys(&:to_sym)
      students << Student.new(x)
    end
    # array_new = students
    
    return students
  end

  

end