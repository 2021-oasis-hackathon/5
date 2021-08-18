class AuthenticationController < ApplicationController
	skip_before_action :authorize_request, only: [:authenticate]

	# POST /login
	def authenticate
		auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
		#auth_token = AuthenticateUser.new("email001@email.com", "pwd").call
		user = User.find_by(auth_params[@email])
		json_response(auth_token: auth_token, id: user.id, name: user.name, role: user.role, phone_number: user.phone_number)
	end

	private

	def auth_params
		params.require(:authentication).permit(
			:email,
			:password,
		)
	end
end