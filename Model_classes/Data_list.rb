require_relative 'Data_table'

class Data_list

  def initialize(data)
    self.array = data

    @selected = []
  end

  def array =(data)
    @array = data
  end

  def select(number)
    raise "Неверный индекс" if (number > array.size()-1 || number < 0)
    if(!@selected.include?(number)) then
      @selected << @array[number]
    else
      index = selected_id.find_index(number)
      @selected.delete_at(index)
    end
  end

  def get_selected()
    seleceted_array_id = []
    for index in 0..@array.size
      seleceted_array_id << @array[index].id if(@selected.include(index))
    end
    return seleceted_array
  end

  def get_names()
    raise NotImplementedError, "Не реализован"
  end

  def get_data()

    table = []
    for index in 0...@array.size()
      table << ([index+1] + attributes(@array[index]))
    end

    return Data_table.new(table)

  end

  def attributes(item)
    raise NotImplementedError, "Не реализован"
  end

end