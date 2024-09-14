#==================================== Задание 6
# Написать программу, которая принимает как аргумент два
# значения. Первое значение говорит, какой из методов задачи 1
# выполнить, второй говорит о том, откуда читать список аргументом
# должен быть написан адрес файла. Далее необходимо прочитать массив
# и выполнить метод.

#Метод поиска минимального элемента в массиве
def search_min_in_array(array)
  min_number = array[0]
  for item in array do
    min_number = item if (item < min_number)
  end
  return min_number
end

#Метод поиска максимального элемента в массиве
def search_max_in_array(array)
  max_number = array[0]
  for item in array do
    max_number = item if (item > max_number)
  end
  return max_number
end

#Метод поиска первого вхождения положительного элемента в массиве, возвращает индекс, дня номера прибавить 1
def search_index_first_positiv_number_in_array(array)
  for index in 0..array.size-1 do
    if(array[index] > 0) then return index end
  end
  return -1
end

#Проверка существования названия файла для записи массива
if ARGV[1] != nil then
  string = File.open("#{ARGV[1]}.txt"){ |file| file.read }
  #Вывод считанного файла
  puts string
  #Разделение элементов строки на элементы массива
  array_from_file = string.split(%r{ \s*}) 
  
  for i in 0..array_from_file.size-1 do
    array_from_file[i] = Float(array_from_file[i])
  end
  
  if (ARGV[0] == "1") then
    result = search_min_in_array(array_from_file)
  elsif (ARGV[0] == "2") then
    result = search_max_in_array(array_from_file)
  elsif (ARGV[0] == "3") then
    result = search_index_first_positiv_number_in_array(array_from_file)
  end

  puts "Ответ = #{result}"
end
