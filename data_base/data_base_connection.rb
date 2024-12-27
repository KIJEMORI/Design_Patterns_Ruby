require "oci8"
require_relative "create_table"
require_relative "insert_in_table_student"

def db_ora_con
  OCI8.new('ruby', '1234', 'localhost')
end

conn = db_ora_con
# create_table(conn)

require_relative '../obs/Student_list_JSON'
require_relative '../obs/Student_list'

json = Student_list_JSON.new()

read = Student_list.new("../obs/list_json_students.json", json)
students = read.read()

students.each do |x| 
  puts x
  insert_into_table_student(conn, x)
end

conn.logoff