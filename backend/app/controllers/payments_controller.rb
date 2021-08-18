class PaymentsController < ApplicationController
	

	
	# GET /payments
	def index
		if (has_host_read_authority?)
			logger.debug("uuuuuu")
			payments = Payment.where(host_id: @current_user.id)
			return json_response(payments, :ok)
		elsif (has_customer_read_authority?)
			payments = Payment.where(customer_id: @current_user.id)
			return json_response(payments, :ok)
		elsif (has_admin_authority?)
			payments = Payment.all
			return json_response(payments, :ok)
		end

		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# GET /payments/:id
	def show
		payment = Payment.find(params[:id])
		if (has_read_authority?(payment))
			return json_response(payment, :ok)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# POST /payments
	def create
		if (has_create_authority?)
			pay = Payment.create!(pay_params)
			return json_response(pay_params, :created)	
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# PUT /payments/:id
	def update
		if (has_update_authority?)
			pay = Payment.find(params[:id])
			pay.update!(user_update_params)
			return json_response(user, :ok)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	# DELETE /payments/:id
	def destroy
		if (has_destroy_authority?)
			Payment.destroy(params[:id])
			return json_response(response, :no_content)
		end
		raise(ExceptionHandler::Unauthorized, Message.unauthorized)
	end

	private

	def pay_params
		params.require(:payment).permit(:price, :status, :customer_id, :host_id, :name)
	end

	def has_customer_read_authority?
		@current_user.role == "customer"
	end

	def has_host_read_authority?
		@current_user.role == "host"
	end

	def has_admin_authority?
		@current_user.role == "admin"
	end

	def user_update_params
		params.require(:payment).permit(:status)
	end

	def has_read_authority?
		@current_user.id == payment.host_id || @current_user.id == payment.customer_id || @current_user.role == "admin"
	end

	def has_create_authority?
		pay_params[:status] == 'paid' && (pay_params[:customer_id].to_i == @current_user.id)
		
	end

	def has_update_authority?
		@current_user.id == params[:host_id].to_i || @current_user.role == 'admin'
	end

	def has_distroy_authority?
		@current_user.role == 'admin'
	end
end
