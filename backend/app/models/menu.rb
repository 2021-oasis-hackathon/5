class Menu < ApplicationRecord
	belongs_to :shop

	validates_presence_of :name, :detail, :price, :image
	validates :name, length: { minimum: 2, maximum: 20 }
	validates :detail, length: { maximum: 200 }
	validates :recommend, inclusion: { in: [true, false ] }
end
