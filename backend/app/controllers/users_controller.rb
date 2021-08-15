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
		# TODO: 하드코딩 멈춰
		if (user_params[:role] != 'customer' && user_params[:role] != 'host')
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		user = User.create!(user_params)
		auth_token = AuthenticateUser.new(user_params[:email], user_params[:password]).call
		response = { message: Message.account_created, auth_token: auth_token}
		json_response(response, :created)
	end

	# PUT /users/:id
	def update
		if (user_params[:role] != 'customer' && user_params[:role] != 'host')
			raise(ExceptionHandler::Unauthorized, Message.unauthorized)
		end
		user = User.find(params[:id])
		user.update!(user_params)
		json_response(user, :ok)
	end

	# DELETE /users/:id
	def destroy
		User.destroy(params[:id])
		response = { message: Message.shop_destroyed }
		json_response(response, :no_content)
	end

	private

	def user_params
		params.require(:user).permit(:email, :name, :nickname, :password, :password_confirmation, :phone_number, :role)
	end
end
