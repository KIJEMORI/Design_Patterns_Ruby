class  Student
  @@ID = 0

  def initialize( string_full_name, options={})
    #да да я знаю что это звучит дико(https://vk.com/video-207565017_456239551)
    @surname = string_full_name.split(" ")

    @ID   =  @@ID
    @@ID  += 1

    @last_name, @first_name, @surname = @surname[0], @surname[1], @surname[2] 

    set_contacts(options)
  end

  #Задание полного фио с помощью одного метода
  def set_full_name(string_full_name)
    @surname    = string_full_name.split(" ")
    @first_name = @surname[0]
    @last_name  = @surname[1]
    @surname    = @surname[2]
  end

  def get_full_name
    String(@last_name)+" "+String(@first_name)+" "+String(@surname)
  end
  
  #Геттеры и сеттеры в одну строчку
  attr_accessor :last_name, :first_name, :surname
  attr_reader :ID, :phone_number, :telegram_account, :mail, :github_account

  #Получить полную информацию
  def to_s
    all_info =   String(@ID)+ ") "  + String(@last_name)
    all_info +=  " "                + String(@first_name)
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


  def validate 
    contacts = Hash[]
    if @github_account != nil
      contacts["Git"] = "Аккаунт гит есть"
    else
      contacts["Git"] = nil
    end
      
    if @phone_number == nil then
      if @telegram_account == nil then
        if @mail == nil then
          contacts["Contact"] = nil
        else
          contacts["Contact"] = "Есть почта"
        end
      else
        contacts["Contact"] = "Есть телеграм аккаунт"
      end
    else
      contacts["Contact"] = "Есть телефон"
    end

    return contacts
  end

  def set_contacts(options = {})
    raise "Некорректный номер телефона"  if Student.is_phone_number(options["Phone"]) == false
    @phone_number     = options["Phone"]

    raise "Некорректный телеграм аккаунт"  if Student.is_telegram_account(options["Telegram"]) == false
    @telegram_account = options["Telegram"]

    raise "Некорректная почта"  if Student.is_mail(options["Mail"]) == false
    @mail             = options["Mail"]

    raise "Некорректная ссылка на гитхаб аккаунт"  if Student.is_github_account(options["Github"]) == false
    @github_account   = options["Github"]
  end

  def getInfo
    all_info =                        String(@last_name)
    all_info +=  " "                + String(@first_name)[0]  + "."
    all_info +=  " "                + @surname[0]             + "."   if @surname           != nil
    all_info +=  "; Github: "       + @github_account                  if @github_account    != nil


    if @phone_number      == nil then
      if @telegram_account  == nil then
        if @mail              != nil then
          all_info +=  "; Mail: "         + @mail
        end
      else
        all_info +=  "; Telegram: "     + @telegram_account 
      end
    else
      all_info +=  "; Phone: "        + @phone_number  
    end

    return all_info
  end

  def get_last_name_and_initials
    all_info =                        String(@last_name)
    all_info +=  " "                + String(@first_name)[0]  + "."
    all_info +=  " "                + @surname[0]             + "."   if @surname           != nil
    return all_info
  end

  def get_one_of_contacts
    
    if @phone_number      == nil then
      if @telegram_account  == nil then
        if @mail              != nil then
          contact =  "Mail: "         + @mail
        end
      else
        contact =  "Telegram: "     + @telegram_account 
      end
    else
      contact =  "Phone: "        + @phone_number  
    end

    return contact
  end

  def self.read_from_txt(file)
    #Открытие файла с данными и чтение их в массив
    lines_from_file = []
    begin
      file = File.open(file,"r")
    rescue => e
      puts e
    end

    while !file.eof?
      lines_from_file  << file.readline
    end

    file.close

    #Инициализация массива для элементов класса Student
    students = []

    #Разбиение каждой строки из файла на элементы для заполнения элементов класса Student
    for index in 0..lines_from_file.size-1 do
      
      #переменная типа Student
      begin
        std = lines_from_file[index].to_Student
      rescue => e
        puts e
      end
      #запись студента в массив
      students << std
      
    end
    return students
  end
end

class Student_short < Student

  def initialize(student)
    @ID = student.ID
    @name = student.get_last_name_and_initials
    @contact = student.get_one_of_contacts
    @github_account = student.github_account
  end

  def Student_short.from_string(id, gInfo)
    @ID = id

    array_of_date = gInfo.split(";")

    #ФИО обязательное для заполнения
    @name = array_of_date[0]
    array_without_name = array_of_date-[@name]

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

    raise "Некорректный номер телефона"  if Student.is_phone_number(hash["Phone"]) == false
    @contact     = hash["Phone"]

    raise "Некорректный телеграм аккаунт"  if Student.is_telegram_account(hash["Telegram"]) == false
    @contact = hash["Telegram"]

    raise "Некорректная почта"  if Student.is_mail(hash["Mail"]) == false
    @contact            = hash["Mail"]

    raise "Некорректная ссылка на гитхаб аккаунт"  if Student.is_github_account(hash["Github"]) == false
    @contact   = hash["Github"]

  end

end

class String
  def to_Student(string_full_info = self)
    #puts string_full_info
    #разбиение на каждый параметр с его значением
    array_of_date = string_full_info.split(";")

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
    
    return Student.new(name, hash)
  end
end