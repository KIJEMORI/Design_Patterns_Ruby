require_relative 'class_People'

class Student_short < People

  def initialize(options ={student: nil, info: nil, id: nil})
    super(options[:id])

    if(!options[:student] && options[:info]!=nil) then
      options[:student] = options[:info].to_Student
    end
    
    raise "Нет данных для заполнения объекта Student_short" if (!options[:student])
      
    @name = options[:student].last_name_and_initials
    @contact = options[:student].one_of_contacts
    @github = options[:student].github

  end

  attr_reader :name, :contact, :github
end
