require_relative 'Student_short'
require_relative 'Data_list'

class Data_list_student_short < Data_list

  def initialize(data)
    super(data)
  end

  def get_names()
    return ["id", "last_name_and_initials", "github", "one_of_contacts"]
  end

  attr_accessor :view

  def count()
    return get_names().size()
  end

  def notify(rows_per_page, data = nil)
    data = get_data() if !data
    names = get_names()
    
    @view.set_table_params(names, rows_per_page)
    
    @view.set_table_data(data)
  end

  private
  def attributes(student_short)
    return [student_short.id, student_short.last_name_and_initials, student_short.github, student_short.one_of_contacts]
  end

end