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
    end.join(" ").gsub("  ", " ").gsub(" ;", ";")
  end
end

class  Student < People
#Конструктор
  def initialize( last_name, first_name, surname = nil, options={ "phone": nil, "telegram":nil, "mail":nil, "github":nil, id: nil})
    super(options[:id])
    set_FIO(last_name: last_name, first_name: first_name, surname: surname)
    set_contacts(options)
  end
#Сеттер фамилии, имени или отчества
  def set_FIO(last_name: @last_name, first_name: @first_name, surname: @surname)
    last_name = last_name.capitalize
    raise "Некорректно введена фамилия"  if !Student.is_name(last_name)
    @last_name = last_name

    first_name = first_name.capitalize
    raise "Некорректно введено имя"  if !Student.is_name(first_name)
    @first_name = first_name

    surname = surname.capitalize if surname != nil
    raise "Некорректно введено отчество"  if Student.is_name(surname) == false
    @surname = surname
  end

#Задание полного фио с помощью одной строки
  def set_full_name(string_full_name)
    #да да я знаю что это звучит дико(https://vk.com/video-207565017_456239551)
    @surname    = string_full_name.split(" ")
    set_FIO(last_name: @surname[0],  first_name: @surname[1], surname: @surname[2])
  end
#Получить полное имя(Фамилия Имя Отчество)
  def get_full_name
    String(@last_name)+" "+String(@first_name)+" "+String(@surname)
  end
  
#Геттеры в одну строчку
  attr_reader :phone, :telegram, :mail, :github, :last_name, :first_name, :surname
  
#Метод класса провеерки регулярными выражениями входных данных, возвращает true, false или nil
  def Student.is_name(maybe_name)
    regex = /^[А-Яё]{1}[а-яё]{1,10} /x
    maybe_name.match?(regex) if maybe_name != nil
  end
  def Student.is_phone (maybe_phone)
    regex = / ^(8|(\+7))  [\s\-(]?  \d{3}  [\s\-)]?  \d{3}   [\s\-]?   \d{2}    [\s\-]?    \d{2}   $ /x
    maybe_phone.match?(regex) if maybe_phone != nil
  end
  def Student.is_telegram (maybe_telegram)
    regex = /  ^@ [a-zA-Z\d\_]{5,32} $ /x
    maybe_telegram.match?(regex) if maybe_telegram != nil
  end
  def Student.is_mail (maybe_mail)
    regex = /^((([0-9A-Za-z]{1}[-0-9A-z\.]{1,}[0-9A-Za-z]{1}))@([-A-Za-z]{1,}\.){1,2}[-A-Za-z]{2,})$ /x
    maybe_mail.match?(regex) if maybe_mail != nil
  end
  def Student.is_github (maybe_github)
    regex = /  ^https: \/ \/ github\.com \/ [a-zA-Z\d\_\-]{5,32} $  /x
    maybe_github.match?(regex) if maybe_github != nil
  end

#Метод подтверждения наличия гита или контакта у студента
  def validate 
    contacts = Hash[]
    if @github != nil
      contacts["Git"] = true
    else
      contacts["Git"] = false
    end
      
    if @phone == nil then
      if @telegram == nil then
        if @mail == nil then
          contacts["Contact"] = false
        else
          contacts["Contact"] = true
        end
      else
        contacts["Contact"] = true
      end
    else
      contacts["Contact"] = true
    end

    return contacts
  end

#Метод задающий или меняющий контакты
  def set_contacts(options = {"phone": @phone, "telegram": @telegram, "mail": @mail, "github": @github})
    
    raise "Некорректный номер телефона"  if Student.is_phone(options["phone"]) == false
    @phone = options["phone"]

    raise "Некорректный телеграм аккаунт"  if Student.is_telegram(options["telegram"]) == false
    @telegram = options["telegram"]

    raise "Некорректная почта"  if Student.is_mail(options["mail"]) == false
    @mail = options["mail"]

    raise "Некорректная ссылка на гитхаб аккаунт"  if Student.is_github(options["github"]) == false
    @github = options["github"]
  end

#Получить фамилию и инициалы, гитхаб (при наличии) и один из контактов (при наличии)
  def getInfo
    all_info =    get_last_name_and_initials
    all_info +=  "; github: " + @github if @github != nil
    all_info += "; " + get_one_of_contacts if get_one_of_contacts != nil
    return get_last_name_and_initials 
  end
#Получить фамилию и инициалы
  def get_last_name_and_initials
    all_info =   @last_name
    all_info +=  " " + @first_name[0]  + "."
    all_info +=  " " + String(@surname[0]) + "." if @surname != nil
    return all_info
  end
#Получить один из контактов (при наличии)
  def get_one_of_contacts
    
    if @phone      != nil then
      return   "phone-" + @phone 
    else
      if @telegram  != nil then
        return   "telegram-"     + @telegram 
      else
        if @mail != nil then
          return "mail-"         + @mail
        end
      end
    end

  end

end

class Student_short < People

  def initialize(options ={student: student, info: str_info, id: nil})
    super(options[:id])
   
    if(!options[:student]) then
      options[:student] = options[:info].to_Student
    end
    
    @name = options[:student].get_last_name_and_initials
    @contact = options[:student].get_one_of_contacts
    @github = options[:student].github
  end

  attr_reader :name, :contact, :github
end

class String
#Функция класса String для создания переменной класса Student из строки
  def to_Student(string_full_info = self)
    
    #разбиение на каждый параметр с его значением
    array_of_date = string_full_info.split(";")

    #ФИО обязательное для заполнения
    name = array_of_date[0].downcase
    array_without_name = array_of_date-[name]
    #разделение фио на разные параметры и запись в массив для дальнейшего извлечения в конструктор
    fio = name.split(" ")
    
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
        hash[stats[index].downcase.delete":"] = stats[index+1]
        index+=2
      end
    end
    
    return Student.new(fio[0], fio[1], fio[2], hash)
  end
end

#функция для чтения данных из файла/ Принимает адрес и имя файла / возвращает массив с элементами класса Student
def read_from_txt(file)
  #Массив для хранениыя строк из файла
  lines_from_file = []
  
  begin
    file = File.open(file,"r")
  rescue => e
    puts e
  end

  while !file.eof?
    lines_from_file  << file.readline.chomp
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

#функция запси данных в файл/ Принимает адрес и имя файла и массив с элементами класса Student
def write_to_txt(file, list_students)

  begin
    file = File.open(file,"w")
  rescue => e
    puts e
  end

  for index in 0..list_students.size
    file << list_students[index].to_s + "\n"
  end
  file.close
end
