require_relative '../obs/data_list_student_short'
require_relative '../obs/studend'
require_relative '../obs/student_short'
require 'fox16'
include Fox


class Student_list_view < FXVerticalFrame

  ROWS_PER_PAGE = 20

  def initialize(parent, file, data_storage_strategy)
    @file = file
    @data_storage_strategy = data_storage_strategy
    super(parent, opts: LAYOUT_FILL)
    setup_table_area()
    setup_filtering_area()
  end

# Установка фильтрующих боксов
  def setup_filtering_area
    filtering_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_SIDE_TOP)
    FXLabel.new(filtering_area, "Фильтрация")

    FXHorizontalFrame.new(filtering_area, opts: LAYOUT_FILL_X) do |frame|
      FXLabel.new(frame, "Фамилия и инициалы:")
      FXTextField.new(frame, 20, opts: TEXTFIELD_NORMAL)
    end

    add_filtering_row(filtering_area, "Git:")
    add_filtering_row(filtering_area, "Email:")
    add_filtering_row(filtering_area, "Телефон:")
    add_filtering_row(filtering_area, "Telegram:")
  end

  def add_filtering_row(parent, label)
    FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X) do |frame|
      FXLabel.new(frame, label)
      combo = FXComboBox.new(frame, 3, opts: COMBOBOX_STATIC | FRAME_SUNKEN)
      combo.numVisible = 3
      combo.appendItem("Не важно")
      combo.appendItem("Да")
      combo.appendItem("Нет")
      text_field = FXTextField.new(frame, 15, opts: TEXTFIELD_NORMAL)
      text_field.enabled = false

      combo.connect(SEL_COMMAND) do
        text_field.enabled = (combo.currentItem == 1)
        text_field.text = '' if (combo.currentItem != 1)
      end
    end
  end
# Установка таблицы
  def setup_table_area
    table_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL)

    @table = FXTable.new(table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE | PACK_NORMAL)

    
    @table.rowHeaderMode = LAYOUT_FIX_WIDTH
    @table.rowHeaderWidth = 25
    @table.columnHeaderHeight = 30
    table.columnHeaderMode = LAYOUT_FIX_HEIGHT


    @controls = FXHorizontalFrame.new(table_area, opts: LAYOUT_FILL_X)
    @prev_btn = FXButton.new(@controls, "<", opts: BUTTON_NORMAL | LAYOUT_LEFT)
    @page_label = FXLabel.new(@controls, "Страница: 1/1", opts: LAYOUT_CENTER_X)
    @next_btn = FXButton.new(@controls, ">", opts: BUTTON_NORMAL | LAYOUT_RIGHT)

    @prev_btn.connect(SEL_COMMAND) { switch_page(-1) }
    @next_btn.connect(SEL_COMMAND) { switch_page(1) }
    @table.columnHeader.connect(SEL_COMMAND) do |_, _, column_index|
      sort_table_by_column(column_index)
    end

    populate_table()
  end
#Геттеры и сеттеры
  private
  attr_accessor :table, :data, :total_pages, :current_page, :page_label, :prev_btn, :next_btn, :sort_order
# Размещение данных в таблице при чтении из JSON файла
  def populate_table
    read = Student_list.new(@file, @data_storage_strategy)
    students = read.read()
    
    students_short = []
    for student in students
      students_short << Student_short.new(student: student)
    end

    data_list = Data_list_student_short.new(students_short)
    
    
    @data = data_list.get_data()
    @names = data_list.get_names()
    @table.setTableSize(ROWS_PER_PAGE, @names.size)

    self.total_pages = ((@data.count_row - 1).to_f / ROWS_PER_PAGE).ceil
    @current_page = 1

    update_table()
  end

  def update_table(sorted_data = nil)
    return if @data.nil? || @data.count_row <= 1

    (0...@data.count_column).each do |col_index|
      self.table.setColumnText(col_index, @names[col_index].to_s)
    end
    clear_table()

    data_to_display = sorted_data || get_page_data(self.current_page)
    data_to_display.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        @table.setItemText(row_index, col_index, cell.to_s)
      end
    end

    @page_label.text = "Страница: #{@current_page}/#{@total_pages}"
  end

  def clear_table
    (0...ROWS_PER_PAGE).each do |row_index|
      (0...@data.count_column).each do |col_index|
        @table.setItemText(row_index, col_index, "")
      end
    end
  end


  def get_page_data(page_number)
    start_index = (page_number - 1) * ROWS_PER_PAGE
    end_index = start_index + ROWS_PER_PAGE - 1
    data_page = []

    (start_index..end_index).each do |row_index|
      break if row_index >= @data.count_row
      row = []
      (0...@data.count_column).each do |col_index|
        row << @data.get(row_index, col_index)
      end
      data_page << row
    end
    data_page
  end


  def switch_page(direction)
    new_page = @current_page + direction
    return if new_page < 1 || new_page > @total_pages
    self.current_page = new_page
    update_table()
  end

  # sort
  def sort_table_by_column(column_index)
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
    update_table()
  end
end