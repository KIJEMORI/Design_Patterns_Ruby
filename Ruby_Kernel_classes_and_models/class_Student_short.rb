require_relative 'class_People'

class Student_short < People

  def initialize(options ={student: nil, info: nil, id: nil})
    

    if(!options[:student] && options[:info]!=nil) then
      options[:student] = options[:info].to_Student
    end
    
    raise "Нет данных для заполнения объекта Student_short" if (!options[:student])
    option = Hash[]
    option[:id] = options[:id]
    option["github"] = options[:student].github

    super(option)

    @last_name_and_initials = options[:student].last_name_and_initials
    @contact = options[:student].one_of_contacts
    

  end

  attr_reader :last_name_and_initials, :contact
end
