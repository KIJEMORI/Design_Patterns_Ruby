require_relative "../obs/studend"

def insert_into_table_student(conn, student)
  command = ""
  
  command +=  "insert into student "
  command +=  "(id, last_name, first_name, surname, github, phone, mail) "
  command +=  "values "
  command +=  "(:1, :2, :3, :4, :5, :6, :7);"
  
  conn.exec(command, (student.id, student.last_name, student.first_name, student.surname, student.github, student.phone, student.mail))
end
