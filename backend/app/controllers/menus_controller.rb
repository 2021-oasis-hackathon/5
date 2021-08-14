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
		menu = Menu.create!(menu_params)
		json_response(menu, :created)
	end

	# PUT /shops/:id/menus/:id
	def update
		menu = Menu.find(params[:id])
		menu.update!(menu_params)
		json_response(menu, :ok)
	end

	# DELETE /shops/:id/menus/:id
	def destroy
		Menu.destroy(params[:id])
		response = { message: Message.menu_destroyed }
		json_response(response, :no_content)
	end

	private

	def menu_params
		params.require(:menu).permit(:name, :detail, :price, :image)
	end
end
