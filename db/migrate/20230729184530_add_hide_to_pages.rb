class AddHideToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :hide, :boolean, :default => false
  end
end
