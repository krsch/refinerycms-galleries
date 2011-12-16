class CreateGalleries < ActiveRecord::Migration

  def self.up
    create_table :galleries do |t|
      t.string :title
      t.text :description
      t.string :folder
      t.integer :position

      t.timestamps
    end

    add_index :galleries, :id

    load(Rails.root.join('db', 'seeds', 'galleries.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "galleries"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/galleries"})
    end

    drop_table :galleries
  end

end
