class AddCustomerCountToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :customer_count, :integer
    add_column :shops, :customer_count_max, :integer
  end
end
