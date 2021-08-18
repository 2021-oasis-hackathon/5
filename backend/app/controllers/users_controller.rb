class UsersController < ApplicationController

	skip_before_action :authorize_request, only: [:create]

	# GET /users
	def index
		users = User.all
		json_response(users, :ok)
	end

	# GET /users/:id
	def show
		user = User.find(params[:id])
		json_response(user, :ok)
	end

	# POST /users
	def create
		if (has_create_authority?)
			user = User.create!(user_params)
			auth_token = AuthenticateUser.new(user_params[:email], user_params[:password]).call
			response = { message: Message.account_created, auth_token: auth_token}
			return json_response(response, :created)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# PUT /users/:id
	def update
		if (has_update_authority?)
			user = User.find(params[:id])
			user.update!(user_update_params)
			return json_response(user, :ok)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# DELETE /users/:id
	def destroy
		if (has_destroy_authority?)
			User.destroy(params[:id])
			response = { message: Message.shop_destroyed }
			return json_response(response, :no_content)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	private

	def user_params
		params.require(:user).permit(:email, :name, :nickname, :password, :password_confirmation, :phone_number, :role, :customer_count, :customer_count_max)
	end

	def user_update_params
		params.require(:user).permit(:name, :nickname, :phone_number, :customer_count, :customer_count_max, :shop_id)
	end

	def has_create_authority?
		user_params[:role] == 'customer' || user_params[:role] == 'host'
	end

	def has_update_authority?
		@current_user.id == params[:id].to_i || @current_user.role == 'admin'
	end

	def has_distroy_authority?
		@current_user.id == params[:id].to_i || @current_user.role == 'admin'
	end
end
