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

  def max()

    return nil if @array.nil? || @array.empty?

    max = @array[0]
    for item in @array
      max = item if yield(item, max) > 0
    end

    return max
  end

  def sort!()

    return nil if @array.nil? || @array.empty?

    new_array = @array.clone()

    for index in 0...new_array.size()
      for index_2 in 0...new_array.size()
        if yield(new_array[index], new_array[index_2])
          item_1 = new_array[index]
          new_array[index] = new_array[index_2]
          new_array[index_2] = item_1 
        end
      end
    end

    return new_array
  end

  def select()
    return nil if @array.nil? || @array.empty?

    new_array = @array.clone()
    not_our_item = []


    for item in new_array
      if !yield(item)
        not_our_item.append(item)
      end
    end

    return new_array - not_our_item
  end

  def map ()

    return nil if @array.nil? || @array.empty?
    new_array = @array.clone()

    for index in 0...new_array.size()
      new_array[index] = yield(new_array[index])
    end

    return new_array

  end

  def detect()

    return nil if @array.nil? || @array.empty?

    new_array = @array.clone()

    for index in 0...new_array.size()
      if yield(new_array[index])
        return new_array[index]
      end
    end

    return nil

  end

  def to_s()
    @array.to_s
  end

end

