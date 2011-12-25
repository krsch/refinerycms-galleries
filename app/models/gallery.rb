class Gallery < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :folder]

  validates :title, :presence => true, :uniqueness => true

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
end
