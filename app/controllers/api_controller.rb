class ApiController < ActionController::API

	def scan
		@reservation=Reservation.find(params[:id])
		if params[:code] == @reservation.code
			if @reservation.scanned
				render json: 'already scanned'
			else
				@reservation.update_column('scanned',true)
				render json: 'valid'
			end
		else
			render json: 'invalid code'
		end
	end

end
