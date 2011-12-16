module Admin
  class GalleriesController < Admin::BaseController

    crudify :gallery, :xhr_paging => true

    before_filter :find_gallery_images, :only => :edit

  protected
    def find_gallery_images
      gallery = Gallery.find(params[:id])
      base = Rails.root.join 'public', 'system', 'galleries', gallery.folder, '*.*'
      @filenames = Dir.glob(base)
      @urlprefix = '/system/galleries/' + gallery.folder + '/'
    end
  end
end
