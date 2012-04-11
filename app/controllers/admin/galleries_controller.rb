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

    def update
      redirect_to :action => :show
    end

    def create
      @gallery = Gallery.new(params[:gallery])
      page_title = @gallery.title
      page = Page.find_by_title(page_title)
      @gallery.page_id = page.id if page
      if @gallery.save
        Dir.mkdir File.join(Gallery::BASE, @gallery.folder)
        redirect_to :action => :index
      else
        @gallery.errors[:title] = @gallery.errors[:page_id]
	@gallery.errors.delete :page_id
        render :action => :new
      end
    end

    def upload
      files = params[:images]
      @gallery = Gallery.find(params[:id])
      files.each do |file|
	if file.content_type == 'application/zip' then
	  Tempfile::open('galleries') do |temp|
	    temp.write(file.read)
	    Zip::ZipInputStream::open(temp.path) do |io|
	      while (entry = io.get_next_entry)
                begin
		  @gallery.add_image entry.get_input_stream.read, entry.name
                rescue
                  if @gallery.list_files.include?(entry.name)
                    path = File.join(Gallery::BASE, @gallery.folder,entry.name)
                    File.delete(path)
                  end
                  logger.error $!
                  logger.error "for gallery #{@gallery} and filename #{entry.name}"
                end
	      end
	    end
	  end
	elsif file.content_type.starts_with?('image/')
          begin
	    @gallery.add_image file.read, file.original_filename
          rescue
            if @gallery.list_files.include?(file.original_filename)
              path = File.join(Gallery::BASE, @gallery.folder,file.original_filename)
              File.delete(path)
            end
            logger.error $!
            logger.error "for gallery #{@gallery} and filename #{file.original_filename}"
          end
	end
      end
      redirect_to :action =>:edit, :id => @gallery.id
    end
  protected
    def find_gallery_images
      #gallery = Gallery.find(params[:id])
      #base = Rails.root.join 'public', 'system', 'galleries', gallery.folder, '*.*'
      @filenames = @gallery.list_files() #Dir.glob(base)
      #@urlprefix = '/system/galleries/' + gallery.folder + '/'
    end
  end
end
