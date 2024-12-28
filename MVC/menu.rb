require 'fox16'
include Fox

class Menu < FXMenuBar

  def initialize(app)
    @app = app
    super(app, LAYOUT_SIDE_TOP | LAYOUT_FILL_X)
    setup_button_area()
  end

  def setup_button_area()
    filemenu = FXMenuPane.new(@app)
    login = FXMenuCommand.new(filemenu, "&Login")
    quit_cmd = FXMenuCommand.new(filemenu, "&Quit\tCtl-Q")
    quit_cmd.connect(SEL_COMMAND) {app.exit}

    tabs = FXMenuPane.new(@app)

    names_tab = ["&Список студентов", "2",  "3"]
    first_tab= FXMenuCommand.new(tabs, names_tab[0])
    first_tab.connect(SEL_COMMAND) {app.exit}

    second_tab= FXMenuCommand.new(tabs, names_tab[1])
    second_tab.connect(SEL_COMMAND) {app.exit}

    third_tab= FXMenuCommand.new(tabs, names_tab[2])
    third_tab.connect(SEL_COMMAND) {app.exit}
  
    FXMenuTitle.new(self, "&File", nil, filemenu)
    FXMenuTitle.new(self, "&Вкладки", nil, tabs)
  end
end

