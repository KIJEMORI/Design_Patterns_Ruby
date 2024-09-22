class  Student
  @@ID = 0
  
  def initialize( string_full_name, phone_number = nil, telegram_account = nil, mail = nil, github_account = nil)
    #да да я знаю что это звучит дико(https://vk.com/video-207565017_456239551)
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
  def get_last_name #метод экземпляра для вывода фамилии
    @last_name
  end
  def set_last_name(last_name)
    @last_name = last_name
  end
  def get_first_name #метод экземпляра для вывода имени
    @first_name
  end
  def set_first_name(first_name)
    @first_name = first_name
  end
  def get_surname #метод экземпляра для вывода отчества
    @surname
  end
  def set_surname(surname)
    @surname = surname
  end

  def get_phone_number #метод экземпляра для вывода телефонного номера
    @phone_number
  end
  def set_phone_nuber(phone_number)
    @phone_number = phone_number
  end

  def get_telegram_account #метод экземпляра для вывода телеграма
    @telegram_account
  end
  def set_telegram_account(telegram_account)
    @telegram_account = telegram_account
  end

  def get_mail #метод экземпляра для вывода почты
    @mail
  end
  def set_mail(mail)
    @mail = mail
  end

  def get_github_account #метод экземпляра для вывода гитхаба
    @github_account
  end
  def set_github_account(github_account)
    @github_account = github_account
  end

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


