class AuthenticationController < ApplicationController
	skip_before_action :authorize_request, only: [:authenticate]

	# POST /login
	def authenticate
		auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
		#auth_token = AuthenticateUser.new("email001@email.com", "pwd").call
		user = User.find_by(email: auth_params[:email])
		json_response(auth_token: auth_token, id: user.id, name: user.name, email: user.email, role: user.role, phone_number: user.phone_number, shop_id: user.shop_id)
	end

	private

	def auth_params
		params.require(:authentication).permit(
			:email,
			:password,
		)
	end
end