class People
  def initialize(id)
    @id = id
  end
  attr_reader :id
#Получение полной информации исходя из переменной объекта класса
  def to_s
    instance_variables.map do |type|
      value = instance_variable_get(type)
      type = type.to_s.delete_prefix('@')
      if type == "last_name" || type == "first_name" || (type == "surname" && value != nil) || type == "name" then
        "#{value}"
      else 
        "; #{type.capitalize}: #{value}" if value != nil
      end
    end.join(" ").gsub("  ", " ").gsub(" ;", ";").sub(" ", "")
  end
end