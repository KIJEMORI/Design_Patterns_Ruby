# Написать класс обработки массива.
# Ваш класс должен принимать массив в конструкторе и не иметь возможность менять массив,
# но иметь возможность получить элементы массива.
# Реализовать  с помощью цикла свои версии методов,
# принимающих блок, как аргумент, указанных в варианте.
# Написать тесты на Ваш класс.

class Processing

  def initialize(array)
    raise "Введите массив" if array.empty?
    @array = array.clone()
  end

# Метод удаляющий первй элемент до тех пор пока не выполниться сравнение в переданном блоке
  def drop_while!()
    return nil if @array.nil? || @array.empty?

    new_array = @array.clone()

    while yield new_array[0]
      new_array.delete_at(0)
    end

    return new_array
  end

  def to_s()
    @array.to_s
  end
  
end

# Проверка
array = [1,2,3,4,5,6,1,3,5,3,567,12]

array_1 = Processing.new(array)

p array_1.drop_while!(){|x| x != 3}
