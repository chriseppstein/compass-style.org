class CreateStylesheets < ActiveRecord::Migration
  def self.up
    create_table :stylesheets, :force => true do |t|
      t.string :title
      t.string :url_name
      t.text :sass
      t.text :css
      t.timestamps
    end
    add_index :stylesheets, :url_name, :unique => true
  end

  def self.down
    remove_index :stylesheets, :column => :url_name
    drop_table :stylesheets
  end
end
