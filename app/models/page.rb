class Page < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true

  before_save :store_body

  def has_changed?
    body != page_body
  end

  def title
    parsed_body.title
  end

  def get_elements(element)
    parsed_body.css(element).map do |item|
      Element.new(item)
    end
  end

  private

  def store_body
    self.body = page_body
  end

  def page_body
    @_page_body ||= HTTParty.get(url).body
  end

  def parsed_body
    Nokogiri::HTML(body)
  end
end
