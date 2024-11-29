class Tag 
  def initialize(tag, layer)
    tag = tag.gsub("<",'').gsub(">",'').split()
    @name = tag[0]
    @parameters = tag[1..tag.size()]
    @layer = layer
  end

  attr_accessor :name, :parameters, :layer, :parent

  attr_reader :childs

  def childs=(child)
    if @childs == nil
      @childs = []
    end
    @childs << child
  end

  def to_s
    info = "Parent: " + @parent.name + ", Tag: " + @name.to_s 
    return  info + ", Childs: " + @childs.map!{|x| x.name}.to_s if have_childs?
    info
  end

  def have_childs?
    return true if(childs != nil)
    return false
  end
end