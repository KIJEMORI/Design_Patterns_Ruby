require_relative "start_window"
require_relative "menu"
require_relative "student_list_view"
require_relative '../obs/student_list_json'
require_relative '../obs/student_list_DB'
require_relative "student_list_controller"
require 'fox16'
include Fox

app = FXApp.new
main = Startwindow.new(app)
Menu.new(main)
json = Student_list_JSON.new("../obs/list_json_students.json",)
db = Student_list_DB.new('postgres', '1234', 'Ruby')

view = Student_list_view.new(main)
controller = Student_list_controller.new(db)

view.controller = controller
controller.view = view

view.start_view()

app.create

app.run