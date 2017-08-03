class DashboardsController < ApplicationController

	def index
	end

	def show
		@concert=Concert.find(params[:id])
		@reservation_types=ReservationType.all
		@category_prices=@concert.seats.pluck(:price).uniq
		@payment_types=Order.pluck(:payment_type).uniq
		@hold_types=Order.pluck(:hold_type).uniq
		@reservations=Reservation.joins(:seat).where(:seats  => {:concert_id => @concert.id}).joins(:order).where(:orders  => {:paid => true})
		@unpaid_reservations=Reservation.joins(:seat).where(:seats  => {:concert_id => @concert.id})
		@held_reservations=Reservation.joins(:seat).where(:seats  => {:concert_id => @concert.id}).joins(:order).where(:orders  => {:held => true})
	end

	def G9w9_Y8mdSmC3HahDKs8J620nPih9_pdyA6IDKUYex8
	end

end
