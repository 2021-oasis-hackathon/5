class Payment < ApplicationRecord
	belongs_to :host, class_name: "User", foreign_key: "host_id"
	belongs_to :customer, class_name: "User", foreign_key: "customer_id"

	validates_presence_of :price, :status, :host_id, :customer_id, :name
	validates :status, inclusion: { in: ['paid', 'ordered', 'cancelled'] }
end

