class Admin::BvrsController < ApplicationController

	before_action :retrieve_order
	
	def create
		if @order.update(order_params)
			@order.place_hold("en attente de paiement")
			@order.reservations.map(&:save)
		    @order.user = current_user
		    @order.save
			render 'show'
			GenerateFactureJob.perform_later(@order)
	    else
	      flash[:alert] = "Votre forumlaire contient #{@order.errors.count} #{"erreur".pluralize(@order.errors.count)}"
	      render 'create'
	    end
	end

	def update
		@order.place_hold("en attente de paiement")
		if @order.update(order_params)
			session.delete(:order_id)
			render 'orders/success'
	    else
	      flash[:alert] = "Votre forumlaire contient #{@order.errors.count} #{"erreur".pluralize(@order.errors.count)}"
	      render 'new'
	    end
	end

	private
    
	    def order_params
	      params.require(:order).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country,:stripe_token,:hold_type)
	    end

end
