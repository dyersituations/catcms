class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.integer :page_type
      t.string :path
      t.oid :banner
      t.text :content
      t.timestamps
    end
  end
end
