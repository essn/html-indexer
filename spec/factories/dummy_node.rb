class DummyNode
  include Enumerable

  attr_accessor :content, :name, :attributes

  def initialize(options = {})
    @content = options[:content]
    @name = options[:name]
    @attributes = options[:attributes]
  end

  def each(&block)
    @attributes.each(&block)
  end
end
