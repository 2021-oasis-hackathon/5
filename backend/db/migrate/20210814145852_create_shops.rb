class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :detail
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :location
      t.string :open_time
      t.integer :order_count, default: 0
      t.string :image

      t.timestamps
    end
  end
end
