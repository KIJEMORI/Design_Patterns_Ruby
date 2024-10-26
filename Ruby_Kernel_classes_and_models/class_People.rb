
class People
  def initialize(options = {id: nil, "github": nil})
    @id = options[:id]
    raise "Некорректная ссылка на гитхаб аккаунт"  if People.is_github?(options["github"]) == false
    @github = options["github"]
  end

  def People.is_github? (maybe_github)
    regex = /  ^https: \/ \/ github\.com \/ [a-zA-Z\d\_\-]{5,32} $  /x
    maybe_github.match?(regex) if maybe_github != nil
  end

  attr_reader :id, :github
#Получение полной информации исходя из переменной объекта класса
  def to_s
    information = instance_variables.map do |type|
      value = instance_variable_get(type)
      type = type.to_s.delete_prefix('@')
      if type == "last_name" || type == "first_name" || (type == "surname" && value != nil) || type == "last_name_and_initials" then
        "#{value}"
      elsif type != "github"
        "; #{type.capitalize}: #{value}" if value != nil
      end
    end.join(" ").gsub("  ", " ").gsub(" ;", ";").sub(" ", "").gsub('_',' ')

    
    information += "; #{"github".capitalize}: #{@github}" if @github != nil
    
    return information
  end

  def last_name_and_initials

  end

  def one_of_contacts

  end
end