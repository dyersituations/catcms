class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.integer :page_id
      t.string :title
      t.string :image
      t.text :content
      t.string :category
      t.timestamps
    end
  end
end
