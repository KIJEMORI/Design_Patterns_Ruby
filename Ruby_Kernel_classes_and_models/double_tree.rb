require_relative 'element_tree'

class Double_tree
  @@stack = []

  def Double_tree.start_with
    return @@stack[0]
  end

  def initialize(student)
    if @@stack.last != nil
      check_element = @@stack[0]

      while true
        if student <= check_element.data and check_element.right != nil
          check_element = check_element.left
        elsif student <= check_element.data and check_element.right == nil
          check_element.left = Element.new(data: student, parent: check_element)
          puts check_element.data
          @@stack << check_element.left
          break
        elsif student > check_element.data and check_element.right != nil
          check_element = check_element.right
        elsif student > check_element.data and check_element.right == nil
          check_element.right = Element.new(data: student, parent: check_element)
          @@stack << check_element.right
          break
        end
      end
    else
      @@stack << Element.new(data: student, parent: nil)
    end
  end

  def Double_tree.sorted_students(item)
    if item.left != nil
      return sorted_students(item.left) + item.data.to_s
    elsif item.right != nil
      return item.data.to_s + sorted_students(item.right)
    elsif item.right == nil && item.left == nil
      return item.data.to_s
    end

  end

end