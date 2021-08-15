class Cart < ApplicationRecord
	belongs_to :customer, class_name: "User"

	validates_presence_of :count, :menu_id, :price
end
