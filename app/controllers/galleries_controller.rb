class GalleriesController < ApplicationController

  before_filter :find_all_galleries
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @gallery in the line below:
    present(@page)
  end

  def show
    @gallery = Gallery.find(params[:id])
    @filenames = @gallery.list_files

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @gallery in the line below:
    present(@page)
  end

protected

  def find_all_galleries
    @galleries = Gallery.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/galleries").first
  end

end
