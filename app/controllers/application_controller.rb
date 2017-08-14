class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  	def check_admin_authorization
      unless user_signed_in? && current_user.admin?
      	redirect_to root_path
      end
    end



	def retrieve_order
		if Order.find_by_id(session[:order_id]).nil?
			redirect_to '/concerts'
		else
			@order = Order.find_by_id(session[:order_id])
			if @order.paid == true
				'orders/success'
			end
		end
	end

end
