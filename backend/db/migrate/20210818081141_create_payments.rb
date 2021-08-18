class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :price
      t.string :status
      t.integer :customer_id
      t.integer :host_id
      t.string :name

      t.timestamps
    end
  end
end
