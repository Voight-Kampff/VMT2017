class Admin::ConcertsController < ApplicationController

	before_action :check_admin_authorization

	def index
	end

	def show
		@concert=Concert.find_by_id(params[:id])
		@types=ReservationType.all
		@keys= @types.map{|i| i.id}
		@stats=Array.new
		@keys.each do |i|
			@stats[i]=@concert.reservations.where(reservation_type_id: @keys[i]).count
		end

	end

end