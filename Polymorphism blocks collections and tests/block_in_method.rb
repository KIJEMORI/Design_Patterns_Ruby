# Задание 1. 
# Использование методов, принимающих блок как аргумент
# Решить предложенные задачи по вариантам. Задание в отдельную программу. 
# Каждая задача отдельный метод БЕЗ ИСПОЛЬЗОВАНИЯ ЦИКЛОВ и РЕКУРСИИ.
# Реализовать выбор пользователя какую задачу решать.
# Чтение из файла или с клавиатуры.

# 1.7	Дан целочисленный массив. 
# Необходимо осуществить циклический сдвиг элементов массива вправо на две позиции.

def cyclic_shift_right_by_two(massive)
  # rotate возвращает новый массив путем вращения self чтобы элемент count , был первым элементом нового массива. 
  yield (massive.map{|x| x.to_i}.rotate(-2))
end

# 1.19	Дан целочисленный массив. 
# Необходимо осуществить циклический сдвиг элементов массива вправо на одну позицию.

def cyclic_shift_right_by_one(massive)
  yield (massive.map{|x| x.to_i}.rotate(-1))
end

# 1.31	Дан целочисленный массив.
# Найти количество чётных элементов.

def count_of_chet(massive)
  yield (massive.map{|x| x.to_i}.select{|x| x%2==0}.size)
end

# 1.43	Дан целочисленный массив. 
# Необходимо найти количество минимальных элементов.

def count_of_min(massive)
  yield (massive.map{|x| x.to_i}.select{|x| x == massive.min}.count)
end

puts '1) заполнить список'
puts '2) циклический сдвиг вправо на две позиции целочисленный массив'
puts '3) циклический сдвиг вправо на одну позицию целочисленный массив'
puts '4) количество чётных элементов целочисленного массива'
puts '5) количество минимальных элементов целочисленного массива'
puts '0) завершение программы'
print 'Ввод: '
variant = gets().to_i

massive = [1,2,3,4,5,10,11,3,22,1,44,1,5,5,5,1]

while variant != 0 do
  if variant == 1 then
    massive=[]
    print 'Элемент: '
    chislo = gets().to_s
    while chislo.chomp != 'end' do
      massive << chislo
      print 'Элемент: '
      chislo = gets().to_s
    end
  end
  cyclic_shift_right_by_two(massive) {|thing| p thing } if variant == 2
  cyclic_shift_right_by_one(massive) {|thing| p thing } if variant == 3
  count_of_chet(massive) {|thing| p thing } if variant == 4
  count_of_min(massive) {|thing| p thing } if variant == 5
  
  print 'Ввод: '
  variant = gets().to_i
end
