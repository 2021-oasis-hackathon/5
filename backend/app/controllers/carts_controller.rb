class CartsController < ApplicationController
	# GET /users/:id/cart
	def index
		
		carts = Cart.where(customer_id: params[:user_id])
		json_response(carts, :ok)
	end

	# GET /users/:id/carts/:id
	def show
		cart = Cart.find(params[:id])
		json_response(cart, :ok)
	end

	# POST /users/:id/carts
	def create
		if (has_create_authority?)
			param = cart_params
			menu = Menu.find(param[:menu_id])
			total_price = param[:count].to_i * menu.price
			param[:price] = total_price.to_s
			param[:customer_id] = params[:user_id]
			logger.debug(param)
			cart = Cart.create!(param)
			return json_response(param, :created)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# PUT /users/:id/carts/:id
	def update
		if (has_update_authority?)
			param = cart_update_params
			menu = Menu.find(param[:menu_id])
			total_price = param[:count].to_i * menu.price
			cart = Cart.find(params[:id])
			cart.update!(shop_params)
			return json_rseponse(cart, :ok)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# DELETE /users/:id/carts/:id
	def destroy
		if (has_destroy_authority?)
			Cart.destory(params[:id])
			response = { message: Message.shop_destroyed }
			return json_response(response, :no_content)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	private

	def cart_params
		params.require(:cart).permit(:count, :price, :menu_id)
	end

	def cart_update_params
		params.require(:cart).permit(:count)
	end

	def has_update_authority?(menu)
		@current_user.id == params[:user_id].to_i || @current_user.role == "admin"
	end

	def has_delete_authority?
		@current_user.id == params[:user_id].to_i || @current_user.role == "admin"
	end

	def has_create_authority?
		@current_user.id == params[:user_id].to_i && @current_user.role == "customer"
	end
end
