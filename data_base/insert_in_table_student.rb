require_relative "../obs/Studend"

def insert_into_table_student(conn, student)
  begin
  command = ""
  
  command +=  "insert into student"
  command +=  "(id, last_name, first_name, surname, github, phone, mail) "
  command +=  "values "
  command +=  "(:id, :last_name, :first_name, :surname, :github, :phone, :mail)"
  
  cursor = conn.parse(command)
  
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
  conn.commit
  rescue => e
    puts e
  end
end
