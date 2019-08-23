class Api::ScansController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		@qrcode = params[:tid].split(/-/)
		@scan=Scan.new(reservation_id: @qrcode[1] ,scanner_user_id: params[:userid])
		@scan.check(@qrcode[2])
		
		if @scan.save
			render :xml => {:message => {:status => 1, :text => "test"}}
		end

		# @reservation=Reservation.find(params[:id])
		# if params[:code] == @reservation.code
		# 	if @reservation.scanned
		# 		render json: 'already scanned'
		# 	else
		# 		@reservation.update_column('scanned',true)
		# 		render json: 'valid'
		# 	end
		# else
		# 	render json: 'invalid code'
		# end
	end

end

