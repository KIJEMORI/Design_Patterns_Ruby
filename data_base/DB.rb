require_relative "../obs/Studend"
require "oci8"

class DB
  def initialize(user, pass)

    self.user = user
    self.pass = pass

  end
  attr_accessor :user, :pass

  def connect()
    begin
      @conn = OCI8.new(@user, @pass, 'localhost')
    rescue =>e
      puts e
    end
  end

  def logoff
    @conn.logoff
  end

  def select_from_table(id: nil, last_name: nil, first_name: nil, surname: nil, github: nil, phone: nil, mail: nil)

    command = 'select * from STUDENT'
  
    where = ' where '
    where += "id = #{id}" if id
    where += "last_name = #{last_name}" if last_name
    where += "first_name = #{first_name}" if first_name
    where += "surname = #{surname}" if surname
    where += "github = #{github}" if github
    where += "phone = #{phone}" if phone 
    where += "mail = #{mail}" if mail
  
    if where != " where "
      command += where 
    end
  
    cursor = @conn.parse(command)
    cursor.exec
    cursor.fetch() do |row| 
      puts row
    end
  end

  def insert_into_table_student(student)
    begin
      command = ""
      
      command +=  "insert into student"
      command +=  "(id, last_name, first_name, surname, github, phone, mail) "
      command +=  "values "
      command +=  "(:id, :last_name, :first_name, :surname, :github, :phone, :mail)"
      
      cursor = @conn.parse(command)
      
      surname = student.surname.encode('UTF-8', 'WINDOWS-1252') if student.surname
      surname = "null" if !student.surname
      github = student.github.encode('UTF-8', 'WINDOWS-1252') if student.github
      github = "null" if !student.github
      phone = student.phone.encode('UTF-8', 'WINDOWS-1252') if student.phone
      phone = "null" if !student.phone
      mail = student.mail.encode('UTF-8', 'WINDOWS-1252') if student.mail
      mail = "null" if !student.mail

      cursor.bind_param(:id, student.id)
      cursor.bind_param(:last_name, student.last_name.encode('UTF-8', 'WINDOWS-1252'))
      cursor.bind_param(:first_name, student.first_name.encode('UTF-8', 'WINDOWS-1252'))
      cursor.bind_param(:surname, surname)
      cursor.bind_param(:github, github)
      cursor.bind_param(:phone, phone)
      cursor.bind_param(:mail, mail)

      cursor.exec
      @conn.commit
    rescue => e
      puts e
    end
  end

  def create_table()
    begin
    @conn.exec(
      "
      create table Student
      (
        id Number,
        last_name Varchar2(100),
        first_name Varchar2(100),
        surname Varchar2(100),
        github Varchar2(100),
        phone Varchar2(17),
        mail Varchar2(100)
      )
      "
    )
    rescue => e
      puts e
    end
  end

  def drop_table()
    begin
      @conn.exe('drop table Student')
      @conn.commit
    rescue => e
      puts e
    end
    
end