class Element
  attr_accessor :content, :name, :attributes

  def initialize(element)
    @attributes = {}
    @content = element.content
    @name = element.name

    element.each do |attr, value|
      @attributes[attr] = value
    end
  end
end
