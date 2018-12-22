class Payments::BvrsController < ApplicationController

	before_action :retrieve_order

	def create
		if @order.update(order_params)
			@order.place_hold("en attente de paiement par BVR")
			@order.reservations.map(&:save)
		    @order.save
		    session.delete(:order_id)
			render 'orders/attentedepaiement'
	    else
	      flash[:alert] = "Votre forumlaire contient #{@order.errors.count} #{"erreur".pluralize(@order.errors.count)}"
	      render 'create'
	    end
	end

	private
    
	    def order_params
	      params.require(:order).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country,:stripe_token,:hold_type)
	    end

end
