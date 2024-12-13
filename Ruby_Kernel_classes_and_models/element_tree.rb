
class Element
  attr_accessor :data, :left, :right, :parent
  def initialize(data:,  parent:, left: nil, right: nil)
    @data = data
    @left = left
    @right = right
    @parent = parent
  end
end