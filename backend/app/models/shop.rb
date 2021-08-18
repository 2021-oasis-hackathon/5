class Shop < ApplicationRecord
	
	has_many :menus, dependent: :destroy
	has_many :customer, class_name: "User"
	has_many :payment
	belongs_to :host, class_name: "User"

	validates_presence_of :name, :detail, :location, :open_time, :latitude, :longitude, :image, :customer_count, :customer_count_max, :status
	validates :name, length: { minimum: 2, maximum: 20 }
	validates :detail, length: { maximum: 200 }
	validates :location, length: { maximum: 200 }
	validates :open_time, length: { maximum: 50 }
end
