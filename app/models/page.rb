class Page < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true

  before_save :store_body

  end

  private

  def store_body
    self.body = page_body
  end

  def page_body
    @_page_body ||= HTTParty.get(url).body
  end
end
