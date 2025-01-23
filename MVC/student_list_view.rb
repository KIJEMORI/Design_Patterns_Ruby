require_relative '../obs/data_list_student_short'
require_relative '../obs/studend'
require_relative '../obs/student_short'
require 'fox16'
include Fox


class Student_list_view < FXVerticalFrame

  def initialize(parent)
    super(parent, opts: LAYOUT_FILL)
    
  end

  attr_accessor :controller

  def start_view()
    setup_table_area()
    @controller.populate_table()

    setup_control_buttons_area()
    setup_filtering_area()
  end
# Установка управляющих кнопок
  def setup_control_buttons_area
    button_area = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    @add_btn = FXButton.new(button_area, "Добавить", opts: BUTTON_NORMAL)
    @edit_btn = FXButton.new(button_area, "Изменить", opts: BUTTON_NORMAL)
    @delete_btn = FXButton.new(button_area, "Удалить", opts: BUTTON_NORMAL)
    @update_btn = FXButton.new(button_area, "Обновить", opts: BUTTON_NORMAL)
    @add_btn.connect(SEL_COMMAND) { on_add() }
    @update_btn.connect(SEL_COMMAND) { on_update() }
    @edit_btn.connect(SEL_COMMAND) { on_edit() }
    @delete_btn.connect(SEL_COMMAND) { on_delete() }
    @table.connect(SEL_SELECTED) { @controller.update_button_states() }
    @table.connect(SEL_DESELECTED) { @controller.update_button_states() }
    @edit_btn.enabled = false
    @delete_btn.enabled = false

    @controller.update_button_states()
  end

  attr_accessor :add_btn, :edit_btn, :delete_btn, :update_btn

  def on_add
    raise 'NotImpicated'
  end
  
  def on_update
    raise 'NotImpicated'
  end
  
  def on_edit
    raise 'NotImpicated'
  end
  
  def on_delete
    raise 'NotImpicated'
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
    @table.columnHeaderMode = LAYOUT_FIX_HEIGHT


    @controls = FXHorizontalFrame.new(table_area, opts: LAYOUT_FILL_X)
    @prev_btn = FXButton.new(@controls, "<", opts: BUTTON_NORMAL | LAYOUT_LEFT)
    @page_label = FXLabel.new(@controls, "Страница: 1/1", opts: LAYOUT_CENTER_X)
    @next_btn = FXButton.new(@controls, ">", opts: BUTTON_NORMAL | LAYOUT_RIGHT)

    @prev_btn.connect(SEL_COMMAND) { @controller.switch_page(-1) }
    @next_btn.connect(SEL_COMMAND) { @controller.switch_page(1) }

    @table.columnHeader.connect(SEL_COMMAND) do |_, _, column_index|
      @controller.sort_table_by_column(column_index)
    end

  end

  attr_accessor :table, :data, :page_label

#Геттеры и сеттеры
  private
  attr_accessor :total_pages,   :prev_btn, :next_btn, :sort_order
  
end