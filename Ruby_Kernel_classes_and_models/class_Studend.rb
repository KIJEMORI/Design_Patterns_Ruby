class  Student
  @@ID = 0
  
  def initialize( string_full_name, options={})
    #да да я знаю что это звучит дико(https://vk.com/video-207565017_456239551)
    @surname = string_full_name.split(" ")

    @ID   =  @@ID
    @@ID  += 1

    @last_name, @first_name, @surname = @surname[0], @surname[1], @surname[2] 
    
    @phone_number     = options["Phone"]
    @telegram_account = options["Telegram"]
    @mail             = options["Mail"]
    @github_account   = options["Github"]
  end

  def get_ID #метод экземпляра для вывода id студента
    @ID
  end
  
  #Задание полного фио с помощью одного метода
  def set_full_name(string_full_name)
    @surname    = string_full_name.split(" ")
    @first_name = @surname[0]
    @last_name  = @surname[1]
    @surname    = @surname[2]
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
  def set_phone_number(phone_number)
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
    may =   String(@ID)+ ") " + @last_name
    may +=  " "               + @first_name
    may +=  " "               + @surname          if @surname           != nil
    may +=  "; Телефон: "     + @phone_number     if @phone_number      != nil
    may +=  "; Телеграм: "    + @telegram_account if @telegram_account  != nil
    may +=  "; Почта: "       + @mail             if @mail              != nil
    may +=  "; Гитхаб: "      + @github_account   if @github_account    != nil

    return may
  end
end


#====================== MAIN ========================

#Открытие файла с данными и чтение их в массив
lines_from_file = []
file = File.open("main.rb","r")

while !file.eof?
  lines_from_file  << file.readline
end

file.close
#Инициализация массива для элементов класса Student
Students = []

#Разбиение каждой строки из файла на элементы для заполнения элементов класса Student
for index in 0..lines_from_file.size-1 do
  #разбиение на каждый параметр с его значением
  array_of_date = lines_from_file[index].split(";")

  #ФИО обязательное для заполнения
  name = array_of_date[0]
  array_without_name = array_of_date-[name]
  
  #Массив для заполнения не обязательных данных студентов со структурой ["Тип данных", "данные", ...]
  stats = []
  for index in 0..array_without_name.size-1 do
    array_without_name[index].split(" ").each{|x| stats<<x}
  end

  #Создание хэша для заполнения необязательных параметров при создание переменной типа Student
  hash = Hash[]
  
  if stats.size > 0 then
    index = 0
    while index < stats.size-1 do
      hash[stats[index].delete ":"] = stats[index+1]
      index+=2
    end
  end

  #переменная типа Student
  std = Student.new(name, hash)
  #запись студента в массив
  Students << std
  
end
#Вывод всех данных о каждом студенте
Students.each {|n| puts n.get_full_information}
