class Cart < ApplicationRecord
	belongs_to :customer, class_name: "User", foreign_key: "customer_id"
	belongs_to :menu, foreign_key: "menu_id"

	validates_presence_of :count, :menu_id, :price, :customer_id
end
