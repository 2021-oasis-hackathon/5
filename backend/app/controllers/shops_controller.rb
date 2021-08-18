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
		if (has_create_authority?)
			param = shop_params
			param[:host_id] = @current_user.id
			shop = Shop.create!(param)
			return json_response(shop, :created)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# PUT /shops/:id
	def update
		shop = Shop.find(params[:id])
		if (has_update_authority?(shop))
			shop.update!(shop_params)
			return json_response(shop, :ok)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# DELETE /shops/:id
	def destroy
		shop = Shop.find(params[:id])
		if (has_delete_authority?(shop))
			Shop.destroy(params[:id])
			response = { message: Message.shop_destroyed }
			return json_response(response, :no_content)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	private

	def shop_params
		params.require(:shop).permit(:name, :detail, :location, :open_time, :latitude, :longitude, :image, :customer_count, :customer_count_max, :status)
	end

	def has_update_authority?(shop)
		@current_user.id == shop.host_id || @current_user.role == "admin"
	end

	def has_delete_authority?(shop)
		@current_user.id == shop.host_id || @current_user.role == "admin"
	end

	def has_create_authority?
		@current_user.role == "host"
	end
end
