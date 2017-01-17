class PagesController < ApplicationController
  def index
    pages = []

    Page.find_each do |page|
      pages << PageSerializer.serialize(page)
    end

    render json: pages, status: 200
  end

  def show
    page = Page.find_or_create_by(url: url)

    page.save if page.changed?

    render json: PageSerializer.serialize(page),
           status: 200
  end

  private

  def url
    params[:id]
  end
end
