class  Student
  @@ID = 0
  
  def initialize( string_full_name, options={})
    #да да я знаю что это звучит дико(https://vk.com/video-207565017_456239551)
    @surname = string_full_name.split(" ")

    @ID   =  @@ID
    @@ID  += 1

    @last_name, @first_name, @surname = @surname[0], @surname[1], @surname[2] 

    raise "Некорректный номер телефона"  if Student.is_phone_number(options["Phone"]) == false
    @phone_number     = options["Phone"]

    raise "Некорректный телеграм аккаунт"  if Student.is_telegram_account(options["Telegram"]) == false
    @telegram_account = options["Telegram"]

    raise "Некорректная почта"  if Student.is_mail(options["Mail"]) == false
    @mail             = options["Mail"]

    raise "Некорректная ссылка на гитхаб аккаунт"  if Student.is_github_account(options["Github"]) == false
    @github_account   = options["Github"]
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
  
  #Геттеры и сеттеры в одну строчку
  attr_accessor :last_name, :first_name, :surname
  attr_reader :ID, :phone_number, :telegram_account, :mail, :github_account

  def phone_number=(phone)
    raise "Некорректный номер телефона"  if Student.is_phone_number(phone) == false
    @phone_number = phone
  end

  def telegram_account=(telegram)
    raise "Некорректный номер телефона"  if Student.is_telegram_account(telegram) == false
    @telegram_account = telegram
  end

  def mail=(new_mail)
    raise "Некорректный номер телефона"  if Student.is_mail(new_mail) == false
    @mail = new_mail
  end

  def github_account=(github)
    raise "Некорректный номер телефона"  if Student.is_github_account(github) == false
    @github_account = github
  end

  #Получить полную информацию
  def to_s
    all_info =   String(@ID)+ ") "  + @last_name
    all_info +=  " "                + @first_name
    all_info +=  " "                + @surname          if @surname           != nil
    all_info +=  "; Phone: "        + @phone_number     if @phone_number      != nil
    all_info +=  "; Telegram: "     + @telegram_account if @telegram_account  != nil
    all_info +=  "; Mail: "         + @mail             if @mail              != nil
    all_info +=  "; Github: "       + @github_account   if @github_account    != nil

    return all_info
  end
  
  
  def Student.is_phone_number (maybe_phone_number)
    regex = / ^(8|(\+7))  [\s\-(]?  \d{3}  [\s\-)]?  \d{3}   [\s\-]?   \d{2}    [\s\-]?    \d{2}   $ /x
    maybe_phone_number.match?(regex) if maybe_phone_number != nil
  end

  def Student.is_telegram_account (maybe_telegram_account)
    regex = /  ^@ [a-zA-Z\d\_]{5,32} $ /x
    maybe_telegram_account.match?(regex) if maybe_telegram_account != nil
  end

  def Student.is_mail (maybe_mail)
    regex = /^((([0-9A-Za-z]{1}[-0-9A-z\.]{1,}[0-9A-Za-z]{1}))@([-A-Za-z]{1,}\.){1,2}[-A-Za-z]{2,})$ /x
    maybe_mail.match?(regex) if maybe_mail != nil
  end

  def Student.is_github_account (maybe_github_account)
    regex = /  ^https: \/ \/ github\.com \/ [a-zA-Z\d\_\-]{5,32} $  /x
    maybe_github_account.match?(regex) if maybe_github_account != nil
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
    array_without_name[index].split(" ", 2).each{|x| stats<<x}
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

Students.each {|n| puts n}

