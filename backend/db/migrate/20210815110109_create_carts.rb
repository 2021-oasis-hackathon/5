class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :price
      t.integer :count

      t.timestamps
    end
  end
end
