class PageSerializer
  attr_accessor :page

  def initialize(page)
    @page = page
  end

  def self.serialize(page)
    new(page).json
  end

  def json
    {
      title: page.title,
      h1: page.get_elements('h1').map(&:as_json),
      h2: page.get_elements('h2').map(&:as_json),
      h3: page.get_elements('h3').map(&:as_json),
      links: page.get_elements('a').map(&:as_json),
      created_at: page.created_at,
      updated_at: page.updated_at
    }.as_json
  end
end
