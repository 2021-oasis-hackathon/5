class Shop < ApplicationRecord
	
	has_many :menus, dependent: :destroy
	has_many :customer, class_name: "User"
	belongs_to :host, class_name: "User"

	validates_presence_of :name, :detail, :location, :open_time, :latitude, :longitude, :image
	validates :name, length: { minimum: 2, maximum: 20 }
	validates :detail, length: { maximum: 200 }
	validates :location, length: { maximum: 200 }
	validates :open_time, length: { maximum: 50 }
end
