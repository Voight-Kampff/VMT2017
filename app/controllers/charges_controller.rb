class ChargesController < ApplicationController

	def new
		if Order.find_by_id(session[:order_id]).nil?
			redirect_to root_path
		else
			@order = Order.find_by_id(session[:order_id])
		end
	end

	def create

		if Order.find_by_id(session[:order_id]).nil?
			redirect_to 'concerts#index'
		else
			@order = Order.find_by_id(session[:order_id])
		end

		# Amount in cents
	  @amount = @order.calculate_price*100

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :source  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => @order.id,
	    :currency    => 'chf'
	  )

	  @order.pay_with_cc
	  @order.save
	  TicketMailer.send_ticket(@order).deliver
	  session.delete(:order_id)

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end

end
