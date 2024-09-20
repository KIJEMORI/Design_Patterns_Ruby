#======== Задание 4 ========
# «Работа с числами». Составить 3 метода для работы с цифрами или
# делителей числа на основании варианта. Каждый метод отдельный
# коммит.

#-------- Метод 1 --------
#Найти сумму простых делителей числа

#Определение простое число или нет, возвращает true или false
def prime_number(experemental)
  if(experemental>1) then
      for i in 2..experemental do
          if(experemental%i==0 && experemental!=i) then 
              return false
          end
      end
      return true
  end
  return false
end
#Метод суммирующий простые делители числа
def search_sum_prime_divisor(number)
  number = number.abs
  sum_prime_divisor = 0
  for i in 2..number do
      if(number%i==0 && prime_number(i)) then 
          sum_prime_divisor+=i
      end
  end
  return sum_prime_divisor
end
#проверка
puts search_sum_prime_divisor(27)

#--------- Метод 2 -----------
#Найти количество нечетных цифр числа, больших 3

#Метод поиска количества нечётных цифр числа больших 3
def quantity_of_digits_numbers(number)
  quantity = 0
  number = number.abs
  while(number > 0)
    if(number%10 > 3 && number%2!=0) then
      quantity+=1
    end
    number /= 10
  end
  return quantity
end
#Проверка
puts quantity_of_digits_numbers(154789)

#--------- Метод 3 -----------
#Найти произведение таких делителей числа, сумма цифр
#которых меньше, чем сумма цифр исходного числа
puts "----------------------"
#Метод для суммирования цифр числа
def sum_of_digits_numbers(number)
  sum_digits_numbers = 0
  while(number > 0)
    sum_digits_numbers+=number%10
    number/=10
  end
  return sum_digits_numbers
end
#Метод поиска произведение таких делителей числа, сумма цифр
#которых меньше, чем сумма цифр исходного числа
def product_of_number_divisor(number)
  product = 1
  number = number.abs
  for i in 2..number do
    if(number%i==0 && sum_of_digits_numbers(i)<sum_of_digits_numbers(number)) then 
      puts i
      product*=i
    end
  end
  return product

end
#Проверка
puts product_of_number_divisor(17)