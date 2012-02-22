class Gallery < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :folder]

  validates :title, :presence => true, :uniqueness => true
  belongs_to :page

  BASE = Rails.root.join 'public', 'system', 'galleries'
  
  def list_files
    path = File.join(BASE, folder, '*.*')
    filenames = Dir.glob(path).map {|f| File.basename(f)}
  end

  def url_for(filename)
    '/system/galleries/' + folder + '/' + filename
  end

  def thumb(filename)
    File.join('.thumb', filename)
  end

  def tag(filename)
    link_to image_tag(url_for(thumb(filename))), url_for(filename), :rel => 'lightbox-gallery'
  end
end
