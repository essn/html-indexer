require 'rails_helper'

RSpec.describe Element do
  let(:attributes) do
    { attr1: 'value1', attr2: 'value2' }
  end

  let(:dummy_node) do
    DummyNode.new(
      content: 'content',
      name: 'name',
      attributes: attributes
    )
  end

  context 'initialization' do
    let(:element) { Element.new(dummy_node) }

    it 'assigns content to node content' do
      expect(element.content).to eq(dummy_node.content)
    end

    it 'assigns name to node name' do
      expect(element.name).to eq(dummy_node.name)
    end

    it 'assigns attributes to a hash of node attributes' do
      expect(element.attributes).to eq(dummy_node.attributes)
    end
  end
end
