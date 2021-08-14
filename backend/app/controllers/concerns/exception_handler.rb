module ExceptionHandler
	extend ActiveSupport::Concern

	class AuthenticationError < StandardError; end
	class MissingToken < StandardError; end
	class InvalidToken < StandardError; end
	class Unauthorized < StandardError; end

	included do
		rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
		rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity_request
		rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity_request
		rescue_from ExceptionHandler::Unauthorized, with: :unauthorized_request
		rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_request
		rescue_from ActiveRecord::RecordNotFound, with: :not_found_request

	end

	private

	# 422 - unprocessable entity
	def unprocessable_entity_request(e)
		json_response( {message: e.message}, :unprocessable_entity)
	end

	# 401 - Unauthorized
	def unauthorized_request(e)
		json_response({message: e.message}, :unauthorized)
	end

	# 404 - Not found
	def not_found_request(e)
		json_response({message: e.message}, :not_found)
	end
end