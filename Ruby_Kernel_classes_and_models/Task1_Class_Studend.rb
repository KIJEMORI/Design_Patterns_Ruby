class  Student
  @@ID = 0
  
  def initialize( string_full_name, phone_number = nil, telegram_account = nil, mail = nil, github_account = nil)
    @surname = string_full_name.split(" ")
    @ID = @@ID
    @@ID += 1
    @last_name, @first_name, @surname = surname[0], surname[1], surname[2] 
    
    @phone_number = phone_number
    @telegram_account = telegram_account
    @mail = mail
    @github_account = github_account
  end

  def get_ID #метод экземпляра для вывода id студента
    @ID
  end
  #Задание полного фио с помощью одного метода
  def set_full_name(string_full_name)
    @surname = string_full_name.split(" ")
    @first_name = surname[0]
    @last_name = surname[1]
    @surname = surname[2]
  end
  def get_full_name
    @last_name+" "+@first_name+" "+String(@surname)
  end
  #Задание и вызов имени фамилии и отчества студента по отдельности
  attr_accessor:first_name
  attr_accessor:last_name
  attr_accessor:surname

  attr_accessor:phone_number
  attr_accessor:telegram_account
  attr_accessor:mail
  attr_accessor:github_account

  #Получить полную информацию
  def get_full_information
    may = String(@ID)+ ") "+ @last_name
    may+=" "+@first_name
    may+=" "+@surname if @surname != nil
    may+="; Телефон: "+@phone_number if @phone_number != nil
    may+="; Телеграм: "+@telegram_account if @telegram_account != nil
    may+="; Почта: "+@mail if @mail != nil
    may+="; Гитхаб: "+@github_account if @github_account != nil
    return may
  end
end


mas = []
file = File.open("main.rb","r")

while !file.eof?
  mas << file.readline
end

file.close
puts mas[2]