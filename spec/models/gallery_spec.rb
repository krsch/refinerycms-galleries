require 'spec_helper'

describe Gallery do

  def reset_gallery(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @gallery.destroy! if @gallery
    @gallery = Gallery.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_gallery
  end

  context "validations" do
    
    it "rejects empty title" do
      Gallery.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_gallery
      Gallery.new(@valid_attributes).should_not be_valid
    end
    
  end

end