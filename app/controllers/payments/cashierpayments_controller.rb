class Payments::CashierpaymentsController < ApplicationController

	#before_action :check_cashier_authorization
	before_action :retrieve_order

	def create
		@order.pay("paiement de caisse")
		@order.user_id=current_user.id
		@order.email=current_user.email
		if @order.save
			GenerateTicketJob.perform_later(@order)
			session.delete(:order_id)
			render 'orders/success'
		else
			flash[:alert] = "Une erreur s'est produite"
		end
	end
end
