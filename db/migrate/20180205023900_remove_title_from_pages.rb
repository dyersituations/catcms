class RemoveTitleFromPages < ActiveRecord::Migration[5.0]
  def change
    remove_column :pages, :title
  end
end
