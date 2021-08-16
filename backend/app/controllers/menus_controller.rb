class MenusController < ApplicationController

	# GET /shops/:id/menus
	def index
		menus = Menu.all
		json_response(menus, :ok)
	end

	# GET /shops/:id/menus/:id
	def show
		menu = Menu.find(params[:id])
		json_response(menu, :ok)
	end

	# POST /shops/:id/menus
	def create
		if (has_create_authority?)
			param = menu_params
			param[:shop_id] = params[:shop_id]
			menu = Menu.create!(param)
			return json_response(menu, :created)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# PUT /shops/:id/menus/:id
	def update
		menu = Menu.find(params[:id])
		if (has_update_authority?(menu))
			menu.update!(menu_params)
			return json_response(menu, :ok)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# DELETE /shops/:id/menus/:id
	def destroy
		if (has_delete_authority?)
			Menu.destroy(params[:id])
			response = { message: Message.menu_destroyed }
			return json_response(response, :no_content)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	private

	def menu_params
		params.require(:menu).permit(:name, :detail, :price, :image)
	end

	def has_update_authority?(menu)
		shop = Shop.find(menu.shop_id)
		(@current_user.id == shop.host_id || @current_user.role == "admin"
	end

	def has_delete_authority?
		shop = Shop.find(menu.shop_id)
		@current_user.id == shop.host_id || @current_user.role == "admin"
	end

	def has_create_authority?
		shop = Shop.find(params[:shop_id])
		@current_user.id == shop.host_id 
	end
end
