require_relative 'Student_short'
require_relative 'Data_list'
class Data_list_student_short < Data_list

  def initialize()
    super()
  end

  def get_names
    return ["id", "last_name_and_initials", "github", "one_of_contacts"]
  end

  def attributes(student_short)
    return [student_short.last_name_and_initials, student_short.github, student_short.one_of_contacts]
  end

end
