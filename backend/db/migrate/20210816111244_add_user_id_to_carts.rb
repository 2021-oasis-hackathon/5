class AddUserIdToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :customer_id, :integer
  end
end
