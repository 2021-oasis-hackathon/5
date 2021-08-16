class AddMenuIdToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :menu_id, :integer
  end
end
