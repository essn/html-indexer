require 'rails_helper'

RSpec.describe :page_serializer do
  let(:url) { 'https://github.com' }
  let!(:page) do
    VCR.use_cassette('page_body') do
      Page.create!(url: url)
    end
  end
  let(:elements) do
    DummyNode.new(
      content: 'content',
      name: 'name',
      attributes: { key1: 'value1' }
    )
  end

  describe '#new' do
    def do_call
      PageSerializer.new(page)
    end

    it 'accepts a single parameter' do
      expect { PageSerializer.new(1, 2) }.to raise_error(ArgumentError)
    end

    it 'defines the page instance variable' do
      expect(do_call.page).to eq(page)
    end
  end

  describe '#serialize' do
    def do_call
      PageSerializer.serialize(page)
    end

    it 'creates a new instance of page serializer' do
      expect(PageSerializer).to receive(:new).with(page).and_call_original

      do_call
    end

    it 'calls json on new instance of page serializer' do
      expect_any_instance_of(PageSerializer).to receive(:json)

      do_call
    end
  end

  describe '.json' do
    let(:serializer) { PageSerializer.new(page) }
    let(:keys) { %w(title h1 h2 h3 links created_at updated_at) }

    def do_call
      serializer.json
    end

    before do
      allow(page).to receive(:get_elements).and_return(elements)
    end

    it 'returns json with correct keys' do
      expect(do_call.keys).to eq(keys)
    end
  end
end
