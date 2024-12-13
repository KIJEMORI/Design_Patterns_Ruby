class Data_table

  def initialize(data)
      @matrix = data
  end

  def count_row()
        return @matrix.size()
    end

    def count_column()
        max = 0
        for index in 0..@matrix.size:
            if(@matrix[index].size()> max):
                max = @matrix[index].size()
            end
        end
        return max
    end

    def get(row, col)
        raise "Значение строки за пределами двумерного массива" if (row > count_row() - 1 || row < 0)
        raise "Значение столбца за пределами двумерного массива" if (col > @matrix[row].size()-1 || col < 0)

        item = @matrix[row][col].copy(0)
        return item
    end
  
end
