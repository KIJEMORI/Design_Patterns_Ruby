require_relative "start_window"
require_relative "menu"
require_relative "student_list_view"
require_relative '../obs/student_list_json'
require 'fox16'
include Fox

app = FXApp.new
main = Startwindow.new(app)
Menu.new(main)
json = Student_list_JSON.new()
Student_list_view.new(main, "../obs/list_json_students.json", json)

app.create

app.run