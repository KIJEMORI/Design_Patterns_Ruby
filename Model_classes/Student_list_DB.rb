
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
  end



  attr_accessor :user, :pass, :database

  def open()
    DB.instance(@user, @pass, @database)
  end

  # В некоторых БД требуется разорвать соединение но в Postgrqsql не требуется
  def close()

  end

  def select ( id: nil, last_name: nil, first_name: nil, surname: nil, github: nil, phone: nil, mail: nil, telegram: nil, limit: nil, offset: nil)

    command = 'select * from STUDENT'

    where = ' where '
    where += "id = #{id}" if id
    where += "last_name = #{last_name}" if last_name
    where += "first_name = #{first_name}" if first_name
    where += "surname = #{surname}" if surname
    where += "github = #{github}" if github
    where += "phone = #{phone}" if phone 
    where += "mail = #{mail}" if mail
    where += "telegram = #{telegram}" if telegram
    

    if where != " where "
      command += where 
    end

    command += "limit #{limit}" if limit
    commant += "offset #offset" if offset


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
  
  def get_k_n_student_short_list(k, n, data_list = nil, parameters_select = {id: nil, last_name: nil, first_name: nil, surname: nil, github: nil, phone: nil, mail: nil, telegram: nil})
    
    array = select(limit: n, offset: k*n)
    
    students_short = []
    for index in 0...n
      item = array[k*n + index]
      if (item != nil) 
        std = Student_short.new(item) 
      else 
        next
      end
      students_short << std
    end

    return Data_list_student_short.new(students_short)
  
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