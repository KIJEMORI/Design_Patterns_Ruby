require 'fox16'
include Fox

class Startwindow < FXMainWindow
  def initialize(app)
    super(app, "hello world", width: 1000, height: 700)
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end