require_relative 'People'


class  Student < People
#Конструктор
  def initialize(options={last_name: ,first_name: , surname: nil, phone: nil,  telegram:nil, mail:nil, github:nil, id: nil, date_of_birth: nil})
    super(options)
    self.name= ({last_name: options[:last_name], first_name: options[:first_name], surname: options[:surname]})
    self.contacts= (options)
    @date_of_birth = options[:date_of_birth]
  end
#Сеттер фамилии, имени или отчества
  def name=(options= {last_name: @last_name, first_name: @first_name, surname: @surname})
    last_name = options[:last_name]
    raise "Некорректно введена фамилия"  if !Student.is_name?(last_name)
    @last_name = last_name.capitalize

    first_name = options[:first_name]
    raise "Некорректно введено имя"  if !Student.is_name?(first_name)
    @first_name = first_name.capitalize

    surname = options[:surname]
    raise "Некорректно введено отчество"  if Student.is_name?(surname) == false
    @surname = surname.capitalize if surname != nil
  end

#Задание полного фио с помощью одной строки
  def full_name=(string_full_name)
    #да да я знаю что это звучит дико(https://vk.com/video-207565017_456239551)
    @surname    = string_full_name.split(" ")
    self.name=({last_name: @surname[0],  first_name: @surname[1], surname: @surname[2]})
  end
#Получить полное имя(Фамилия Имя Отчество)
  def full_name
    String(@last_name)+" "+String(@first_name)+" "+String(@surname)
  end
  
#Геттеры в одну строчку
  attr_reader :phone, :telegram, :mail, :last_name, :first_name, :surname, :date_of_birth
  
#Метод класса провеерки регулярными выражениями входных данных, возвращает true, false или nil
  def Student.is_name?(maybe_name)
    regex = /^[А-Яё]{1}[а-яё]{1,10} /x
    maybe_name.capitalize.match?(regex) if maybe_name != nil
  end
  def Student.is_phone? (maybe_phone)
    regex = / ^(8|(\+7))  [\s\-(]?  \d{3}  [\s\-)]?  \d{3}   [\s\-]?   \d{2}    [\s\-]?    \d{2}   $ /x
    maybe_phone.match?(regex) if maybe_phone != nil
  end
  def Student.is_telegram? (maybe_telegram)
    regex = /  ^@ [a-zA-Z\d\_]{5,32} $ /x
    maybe_telegram.match?(regex) if maybe_telegram != nil
  end
  def Student.is_mail? (maybe_mail)
    regex = /^((([0-9A-Za-z]{1}[-0-9A-z\.]{1,}[0-9A-Za-z]{1}))@([-A-Za-z]{1,}\.){1,2}[-A-Za-z]{2,})$ /x
    maybe_mail.match?(regex) if maybe_mail != nil
  end
  

#Методы подтверждения наличия гита или контакта у студента
  def validate? 
    return (validate_github? && validate_contact?)
  end

  def validate_contact?
    return true if one_of_contacts != nil
    return false
  end
#Метод задающий или меняющий контакты

  def contacts=(options = {phone: @phone, telegram: @telegram, mail: @mail, github: @github})
    
    raise "Некорректный номер телефона"  if Student.is_phone?(options[:phone]) == false
    @phone = options[:phone]

    raise "Некорректный телеграм аккаунт"  if Student.is_telegram?(options[:telegram]) == false
    @telegram = options[:telegram]

    raise "Некорректная почта"  if Student.is_mail?(options[:mail]) == false
    @mail = options[:mail]

  end

#Получить фамилию и инициалы, гитхаб (при наличии) и один из контактов (при наличии)
  def getInfo
    all_info =    last_name_and_initials
    all_info +=  "; github: " + @github if @github != nil
    all_info += "; " + one_of_contacts if one_of_contacts != nil
    return all_info
  end
#Получить фамилию и инициалы
  def last_name_and_initials
    all_info =   @last_name
    all_info +=  " " + @first_name[0]  + "."
    all_info +=  " " + String(@surname[0]) + "." if @surname != nil
    return all_info
  end
#Получить один из контактов (при наличии)
  def one_of_contacts
    
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

  include Comparable
# Оператор сравнения
  def <=> (object)
    if(object == nil)
      return 1
    elsif (@date_of_birth == nil)
      return -1
    elsif(object > @date_of_birth)
      return -1
    elsif object == @date_of_birth
      return 0
    else
      return 1
    end
  end

  def to_h
    { id: @id, first_name: @first_name, last_name: @last_name, surname: @surname, 
    date_of_birth: @date_of_birth, telegram: @telegram, mail: @mail, phone: @phone, github: @github }
  end
end


