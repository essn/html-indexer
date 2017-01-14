require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:url) { 'https://github.com/' }
  subject { Page.new(url: url) }

  context 'validations' do
    before do
      allow(subject).to receive(:store_body).and_return(nil)
    end

    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
  end

  context 'callbacks' do
    context 'before save' do
      let(:body) do
        VCR.use_cassette 'page_body' do
          HTTParty.get(url).body
        end
      end

      def do_call
        VCR.use_cassette 'page_body' do
          subject.save!
        end
      end

      it 'calls store_body' do
        expect(subject).to receive(:store_body)

        do_call
      end

      it 'sets body attribute' do
        expect { do_call }.to change(subject, :body).from('').to(body)
      end
    end
  end

  context 'instance methods' do
    subject do
      VCR.use_cassette 'page_body' do
        Page.create!(url: url)
      end
    end

    let(:body) do
      VCR.use_cassette 'page_body' do
        Nokogiri.parse(HTTParty.get(url).body)
      end
    end

    describe '.title' do
      def do_call
        subject.title
      end

      it 'returns the page title' do
        expect(do_call).to eq body.title
      end
    end

    describe '.get_elements' do
      def do_call
        subject.get_elements('h1')
      end

      it 'returns an array of Element objects' do
        expect(do_call.class).to eq(Array)
      end
    end
  end
end
