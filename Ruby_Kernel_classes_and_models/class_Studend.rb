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
end