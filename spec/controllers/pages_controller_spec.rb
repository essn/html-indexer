require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:url) { 'https://github.com/' }
  let(:elements) do
    (0..2).map do |i|
      DummyNode.new(
        content: "content#{i}",
        name: "name#{i}",
        attributes: { "attr#{i}" => "value#{i}" }
      )
    end
  end
  let!(:page) do
    VCR.use_cassette('page_body') do
      Page.create!(url: url)
    end
  end

  before do
    allow_any_instance_of(Page).to receive(
      :get_elements
    ).and_return(elements)
  end

  describe '#create' do
    def do_request
      VCR.use_cassette('page_body') do
        post :create, params: { url: url }
      end
    end

    context 'page exists' do
      context 'page body has not changed' do
        it 'does not update page body' do
          expect { do_request }.to_not change(page, :body)
        end

        it 'page does not receive save' do
          expect_any_instance_of(Page).to_not receive(:save)

          do_request
        end
      end

      context 'page body has changed' do
        before do
          allow_any_instance_of(Page).to receive(
            :changed?
          ).and_return(true)
        end

        it 'does receive save' do
          expect_any_instance_of(Page).to receive(:save)

          do_request
        end
      end

      it 'returns status 200' do
        do_request

        expect(response.status).to eq(200)
      end
    end

    context 'page does not exist' do
      before do
        Page.destroy_all
      end

      context 'new page' do
        it 'is created' do
          expect { do_request }.to change(Page, :count).by(1)
        end

        it 'url is equal to id param' do
          do_request

          expect(Page.last.url).to eq(url)
        end
      end

      it 'returns status 201' do
        do_request

        expect(response.status).to eq(200)
      end
    end

    it 'returns a serialized page object' do
      do_request

      expect(
        JSON.parse(response.body)
      ).to eq(
        PageSerializer.serialize(page)
      )
    end
  end

  describe '#index' do
    def do_request
      get :index
    end

    it 'returns an array of all page objects' do
      do_request

      expect(JSON.parse(response.body)).to eq(
        Page.all.map { |page| PageSerializer.serialize(page) }
      )
    end

    it 'returns a status 200' do
      do_request

      expect(response.status).to eq(200)
    end
  end
end
