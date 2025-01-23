require_relative "../obs/Student_list.rb"

class Student_list_controller

  ROWS_PER_PAGE = 1

  def initialize(strategy)
    @strategy = Student_list.new(strategy)
    @sort_parametr =  {id: nil, last_name: nil, first_name: nil, surname: nil, github: nil, phone: nil, mail: nil, telegram: nil, sort_column: nil, sort: "ASC" }
  end

  attr_accessor :view

# Получить выделенные строки(ПОТОМ)
  def get_selected_rows
    selected_rows = []
    (0...@view.table.numRows).each do |row|
      selected_rows << row if @view.table.rowSelected?(row)
    end
    return selected_rows
  end

# Размещение данных в таблице при чтении из выбранной стратегии
  def populate_table(data_storage_strategy = nil)
    
    @current_page = 1
    @strategy = Student_list.new(data_storage_strategy) if !@strategy && data_storage_strategy != nil
    @strategy.data_storage_strategy = data_storage_strategy if @strategy && data_storage_strategy != nil

    @data = get_page_data(@current_page)
    @data_list.view = @view

    @data_list.notify(ROWS_PER_PAGE, @data)

    self.total_pages = ((@strategy.get_student_short_count()).to_f / ROWS_PER_PAGE).ceil
    @view.page_label.text = "Страница: #{@current_page}/#{@total_pages}"
  end

  attr_accessor :total_pages, :current_page, :sort_order, :data

  def switch_page(direction)
    new_page = @current_page + direction
    return if new_page < 1 || new_page > @total_pages
    @current_page = new_page
    update_table()
  end

  def update_table(sorted_data = nil)

    self.total_pages = ((@strategy.get_student_short_count()).to_f / ROWS_PER_PAGE).ceil
    
    clear_table()

    data_to_display = sorted_data || get_page_data(@current_page)
    
    @data_list.notify(ROWS_PER_PAGE, data_to_display)

    @view.page_label.text = "Страница: #{@current_page}/#{@total_pages}"

  end

  def get_page_data(page_number)
    start_index = 0
    end_index = ROWS_PER_PAGE - 1
    data_page = []

    @data_list = @strategy.get_k_n_student_short_list(@current_page-1, ROWS_PER_PAGE, @sort_parametr)
    @data_list.view = @view


    @data = @data_list.get_data
    
    (start_index..end_index).each do |row_index|
      break if row_index >= @data.count_row
      row = []
      (0...@data.count_column).each do |col_index|
        
        row << @data.get(row_index, col_index)
      end
      
      data_page << row
    end

    return data_page
  end

  def clear_table
    (0...ROWS_PER_PAGE).each do |row_index|
      (0...@data_list.count).each do |col_index|
        @view.table.setItemText(row_index, col_index, "")
      end
    end
  end

  # sort
  def sort_table_by_column(column_index)

    begin

      names = @data_list.get_names()
      check = @sort_parametr[:sort_column]
      @sort_parametr[:sort_column] = names[column_index]

      if check == names[column_index]
        
        if @sort_parametr[:sort] == "ASC"
          @sort_parametr[:sort] = "DESC"
        elsif @sort_parametr[:sort] == "DESC"
          @sort_parametr[:sort] = "ASC" 
        end
      else
        @sort_parametr[:sort] = "ASC" 
      end
      
      update_table()

      

    rescue
      
      return if @data.nil? || @data.count_row <= 1
      
      rows = (0...@data.count_row).map do |row_index|
        (0...@data.count_column).map { |col_index| @data.get(row_index, col_index)}
      end
      
      self.sort_order ||= {}
      self.sort_order[column_index] = !sort_order.fetch(column_index, false)

      sorted_rows = rows.sort_by { |row| row[column_index] || ""}
      sorted_rows.reverse! unless self.sort_order[column_index]

      all_rows = sorted_rows

      @data = Data_table.new(all_rows)

      update_table(all_rows)
    end

    
  end



  def update_button_states
    selected_rows = get_selected_rows()
  
    @view.add_btn.enabled = true
    @view.update_btn.enabled = true
  
    case selected_rows.size
    when 0
      @view.edit_btn.enabled = false
      @view.delete_btn.enabled = false
    when 1
      @view.edit_btn.enabled = true
      @view.delete_btn.enabled = true
    else
      @view.edit_btn.enabled = false
      @view.delete_btn.enabled = true
    end
  end

end