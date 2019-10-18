class Admin::ConcertsController < ApplicationController

	before_action :check_admin_authorization

	def index
	end

	def show
		@concert=Concert.find_by_id(params[:id])
		@types=@concert.reservation_types
		@keys= @types.map{|i| i.id}
		@stats=Array.new
		@keys.each do |i|
				@stats.push((@concert.reservations.where(reservation_type_id: @keys[i-1])).count)

		end

	end

end