class CartsController < ApplicationController
	# GET /users/:id/cart
	def index
		carts = Cart.all
		json_response(carts, :ok)
	end

	# GET /users/:id/carts/:id
	def show
		cart = Cart.find(params[:id])
		json_response(cart, :ok)
	end

	# POST /users/:id/carts
	def create
		if (@current_user.role == "host")
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		param = cart_params
		#param[:menu_id] = params[:menu_id]
		menu = Menu.find(param[:menu_id])
		total_price = param[:count].to_i * menu.price
		param[:price] = total_price.to_s
		#param[:customer_id] = current_user.id
		cart = Carts.create!(param)
		json_response(param, :created)
	end

	# PUT /users/:id/carts/:id
	def update
		if (@current_user.role == "host")
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		shop = Shop.find(params[:id])
		shop.update!(shop_params)
		json_rseponse(shop, :ok)
	end

	# DELETE /users/:id/carts/:id
	def destroy
		if (@current_user.role == "host")
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		Shop.destroy(params[:id])
		response = { message: Message.shop_destroyed }
		json_response(response, :no_content)
	end

	private

	def cart_params
		params.require(:cart).permit(:count, :price, :menu_id)
	end
end
