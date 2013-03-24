class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :page_path
      t.string :title
      t.string :image
      t.text :content

      t.timestamps
    end
  end
end
