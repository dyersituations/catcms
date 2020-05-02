class CreateEditorImages < ActiveRecord::Migration[4.2]
  def change
    create_table :editor_images do |t|
      t.string :file
      t.string :alt
      t.timestamps
    end
  end
end
