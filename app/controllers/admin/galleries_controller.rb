module Admin
  class GalleriesController < Admin::BaseController

    crudify :gallery, :xhr_paging => true

    before_filter :find_gallery_images, :only => :edit

    def delete_image
      gallery = Gallery.find(params[:id])
      filename = params[:image_name] + '.' + params[:format]
      base = Rails.root.join 'public', 'system', 'galleries', gallery.folder
      File.delete File.join(base,filename)
      File.delete File.join(base,'.thumb',filename)
    end
  protected
    def find_gallery_images
      gallery = Gallery.find(params[:id])
      base = Rails.root.join 'public', 'system', 'galleries', gallery.folder, '*.*'
      @filenames = Dir.glob(base)
      @urlprefix = '/system/galleries/' + gallery.folder + '/'
    end
  end
end
