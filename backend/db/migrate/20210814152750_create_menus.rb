class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.string :detail
      t.integer :price
      t.string :image
      t.integer :order_count, default: 0

      t.timestamps
    end
  end
end
