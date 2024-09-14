#============ Задание 5
# Написать методы, которые находят минимальный,
# элементы, номер первого положительного элемента. Каждая
# операция в отдельном методе. Решить задачу с помощью
# циклов(for и while)

def search_min_in_array(array)
  min_number = array[0]
  for i in array do
    min_number = i if (i < min_number)
  end
  return min_number
end

def search_items_in_array(array, number)
  for i in array do
    return true if i == number
  end
  return false
end

def search_index_first_positiv_number_in_array(array)
  for i in 0..array.size-1 do
    if(array[i] > 0) then return i end
  end
  return -1
end
array = [5,4,1,4,3,2]
puts search_min_in_array(array)
array1 = [-1,-2,-3]
index_first_positiv_number_in_array = search_index_first_positiv_number_in_array(array1)
if index_first_positiv_number_in_array!=-1 then
puts "номер первого положительно элемента #{index_first_positiv_number_in_array+1}, индекс - #{index_first_positiv_number_in_array}"
else puts "нет положительного элемента" end

puts search_items_in_array(array,7)

#==================================== Задание 6
if ARGV[1] != nil then
  string = File.open("#{ARGV[1]}.txt"){ |file| file.read }
  puts string
  array_from_file = string.split(%r{ \s*}) 
  
  for i in 0..array_from_file.size-1 do
    array_from_file[i] = array_from_file[i].to_i
  end
  
  if (ARGV[0] == "1") then
    result = search_min_in_array(array_from_file)
  elsif (ARGV[0] == "2") then
    puts "Введите элемент для поиска"
    search_item = STDIN.gets
    result = search_items_in_array(array_from_file, search_item)
  elsif (ARGV[0] == "3") then
    result = search_index_first_positiv_number_in_array(array_from_file)
  end

  puts "Ответ = #{result}"
end




