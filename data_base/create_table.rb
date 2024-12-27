def create_table(conn)
  begin
  conn.exec(
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