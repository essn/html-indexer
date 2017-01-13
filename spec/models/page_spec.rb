require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:url) { 'http://www.google.com' }
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
end
