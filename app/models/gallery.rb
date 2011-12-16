class Gallery < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :folder]

  validates :title, :presence => true, :uniqueness => true
  
end
