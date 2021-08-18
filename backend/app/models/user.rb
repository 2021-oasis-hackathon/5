class User < ApplicationRecord
	has_secure_password

	has_one :shop, dependent: :destroy, foreign_key: "shop_id"
	has_many :carts, dependent: :destroy
	has_many :payments

	validates_presence_of :name, :email, :password_digest, :phone_number, :nickname, :role
	validates :name, length: { minimum: 2, maximum: 20 }
	validates :nickname, length: { minimum: 2, maximum: 20 }
	validates :phone_number, format: { with: /\d{3}-\d{4}-\d{4}/, message: "올바르지 않는 형식입니다." }
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true
	validates :role, inclusion: { in: ['customer', 'host', 'admin'] }
	
	def is_customer?
		self.role == "customer"
	end

	def is_shop?
		self.role == "host"
	end

	def is_admin?
		self.role == "admin"
	end
end
