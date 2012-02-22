module Admin
require 'zip/zip'
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

    def upload_new
      @gallery = Gallery.find(params[:id])
    end

    def upload
      files = params[:images]
      @gallery = Gallery.find(params[:id])
      files.each do |file|
	if file.content_type == 'application/zip' then
	  Zip::ZipInputStream::open(file.read) do |io|
	    while (entry = io.get_next_entry)
	      add_image entry.read, entry.name
	    end
	  end
	elsif file.content_type.startsWith('image/')
	  add_image file.read, file.original_filename
	end
      end
    end
  protected
    def find_gallery_images
      #gallery = Gallery.find(params[:id])
      #base = Rails.root.join 'public', 'system', 'galleries', gallery.folder, '*.*'
      @filenames = @gallery.list_files() #Dir.glob(base)
      #@urlprefix = '/system/galleries/' + gallery.folder + '/'
    end

    def add_image(file, name)
      path = File.join(Gallery::BASE, @gallery.folder, name)
      File.open(path, 'wb') { |f| f.write(file) }
      im = Dragonfly[:images].fetch_file(path)
      unless im.height<1000 && im.width <1000
	im.process(:resize, '1000x1000').encode(:jpg, '-quality 80').to_file(path)
      end
      im.thumb('200x200').encode(:jpg, '-quality 80').to_file(File.join(Gallery::BASE, @gallery.folder, '.thumb', name))
    end
  end
end
