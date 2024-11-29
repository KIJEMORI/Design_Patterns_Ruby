class Html
  def initialize(file)
    raise "Неверный файл" if !Html.html?(file)
    data_of_file = File.read(file)
    array_of_data, layers = parse_html(data_of_file)

    end

    
  end
# Проверка файла на тип html
  def Html.html?(maybe_html)
    regex = /.html$/x
    maybe_html.match?(regex) if maybe_html != nil
  end
# Парсинг строки для извлечения тегов и данных
  def parse_html(html_string)
    stack = []
    array_for_data = []
    current_parent = nil
    array_of_layers = []
    layer = 0
    array_of_data = html_string.scan(/<[^>]+>|[^<]+/).map(){|x| x.strip}
    
    for index in 0...array_of_data.size

      if(array_of_data[index].start_with?("<"))
        
        if array_of_data[index].start_with?("</")
          if array_of_data[index].sub("\/", '') != stack.last
            item = array_of_data[index].sub("\/", '').sub(">",'')
            index_in_stack = stack.unshift.index(stack.select{|x| x.include?(item)}.last)
            layer = array_of_layers[index_in_stack]
            stack[index_in_stack] = "GOOD"
          else
            layer -= 1
          end
        elsif array_of_data[index].end_with?("/>")
          array_of_layers << layer
          stack << array_of_data[index]
          array_for_data << array_of_data[index]
        else
          array_of_layers << layer
          layer += 1
          stack << array_of_data[index]
          array_for_data << array_of_data[index]
        end
      end
    end
    return array_for_data, array_of_layers
  end
  
end

file = 'index.html'

Html.new(file)
