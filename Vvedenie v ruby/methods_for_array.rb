#============ Задание 5
# Написать методы, которые находят минимальный,
# элементы, номер первого положительного элемента. Каждая
# операция в отдельном методе. Решить задачу с помощью
# циклов(for и while)

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

#Проверка методов
array = [5,4,1,4,3,2]
puts search_min_in_array(array)
puts search_max_in_array(array)
array1 = [-1,-2,-3]
index_first_positiv_number_in_array = search_index_first_positiv_number_in_array(array1)
if index_first_positiv_number_in_array!=-1 then
puts "номер первого положительно элемента #{index_first_positiv_number_in_array+1}, индекс - #{index_first_positiv_number_in_array}"
else puts "нет положительного элемента" end

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





