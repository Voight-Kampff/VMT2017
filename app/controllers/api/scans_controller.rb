class Api::ScansController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		@qrcode = params[:tid].split(/-/)
		@scan=Scan.new(reservation_id: @qrcode[1] ,scanner_user_id: params[:userid])
		@scan.check(@qrcode[2])
		if @scan.status == true
			status=1
		else
			status=0
		end
		
		if @scan.save
			render :xml => {:message => {:status => status, :text => @scan.message}}
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

		#curl -d "tid=r-18923-9BqZgA2uCxwo3T947_pGrpv0bBk userid=23213123" -X POST https://musicales-tannay.herokuapp.com/api/scans

	end

end

