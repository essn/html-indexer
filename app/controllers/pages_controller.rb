class PagesController < ApplicationController
  def index
    pages = []

    Page.find_each do |page|
      pages << PageSerializer.serialize(page)
    end

    render json: pages, status: 200
  end

  def create
    page = Page.find_or_create_by(url: params[:url])
    status = 200

    page.save && status = 201 if page.changed?

    render json: PageSerializer.serialize(page),
           status: status
  end
end
