require "oci8"
require_relative "create_table"
require_relative "insert_in_table_student"

def db_ora_con
  OCI8.new('ruby', '1234', 'localhost')
end

conn = db_ora_con

conn.logoff
