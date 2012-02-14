class AddPageIdToGalleries < ActiveRecord::Migration
  def self.up
    change_table :galleries do |t|
      t.references :page
    end
  end

  def self.down
    change_table :galleries do |t|
      t.remove_column :page_id
    end
  end
end
