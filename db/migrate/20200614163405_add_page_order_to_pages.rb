class AddPageOrderToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :page_order, :integer, :default => 0
  end
end
