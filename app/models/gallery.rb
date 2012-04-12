class Gallery < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :folder]

  #validates :title, :presence => true, :uniqueness => true
  validates :page_id, :presence => true, :uniqueness => true
  validates_associated :page
  validates :folder, :uniqueness => { :case_sensitive => false }, :format => {:with => /[_A-Za-z0-9]+/, :message => 'Must consist of letters, numbers and underscopes'}
  belongs_to :page

  BASE = Rails.root.join 'public', 'system', 'galleries'
  
  def list_files
    path = File.join(BASE, folder, '*.*')
    filenames = Dir.glob(path).sort.map {|f| File.basename(f)}
  end

  def url_for(filename)
    '/system/galleries/' + folder + '/' + filename
  end

  def thumb(filename)
    File.join File.dirname(filename), '.thumb', File.basename(filename, '.*') + '.jpg'
  end

  def thumb_url(filename)
    url_for(thumb(filename))
  end

  def tag(filename)
    link_to image_tag(thumb_url(filename)), url_for(filename), :rel => 'lightbox-gallery'
  end

  def add_image(file, name)
    basename = File.basename name, '.*'
    path = File.join(BASE, folder, name)

    File.open(path, 'wb') { |f| f.write(file) }
    im = Dragonfly[:images].fetch_file(path)
    unless im.height<1000 && im.width <1000
      newpath = File.join(BASE, folder, basename + '.jpg')
      im.process(:resize, '1000x1000').encode(:jpg, '-quality 80').to_file(newpath)
      File.delete path unless File.extname(name) == '.jpg'
      path = newpath
      im = Dragonfly[:images].fetch_file(path)
    end
    im.thumb('200x200').encode(:jpg, '-quality 80').to_file(thumb(path))
  end
end
