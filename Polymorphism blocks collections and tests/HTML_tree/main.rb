require_relative 'Tag'
require_relative 'Html'


file = 'index.html'

html = Html.new(file)

puts html.tree