class Admin::ConcertsController < ApplicationController

	before_action :check_admin_authorization

	def index
	end

	def show
		@concert=Concert.find_by_id(params[:id])
		@types=ReservationType.all
		@stats=Array.new
		@types.each do |i|
			@stats.push(@concert.reservations.where(reservation_type_id: i.id).count)
		end

	end

end