class ShopsController < ApplicationController
	# GET /shops
	def index
		shops = Shop.all
		json_response(shops, :ok)
	end

	# GET /shops/:id
	def show
		shop = Shop.find(params[:id])
		json_response(shop, :ok)
	end

	# POST /shops
	def create
		if (@current_user.role == "customer")
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		param = shop_params
		param[:host_id] = @current_user.id
		shop = Shop.create!(param)
		#shop.user_id = @current_user.id
		#logger.debug(shop)
		#shop.save
		#shop = Shop.create!(shop_params)
		json_response(shop, :created)
	end

	# PUT /shops/:id
	def update
		if (@current_user.role == "customer")
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		shop = Shop.find(params[:id])
		shop.update!(shop_params)
		json_rseponse(shop, :ok)
	end

	# DELETE /shops/:id
	def destroy
		if (@current_user.role == "customer")
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		Shop.destroy(params[:id])
		response = { message: Message.shop_destroyed }
		json_response(response, :no_content)
	end

	private

	def shop_params
		params.require(:shop).permit(:name, :detail, :location, :open_time, :latitude, :longitude, :image)
	end
end
