class AddShopIdToMenu < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :shop_id, :integer
  end
end
