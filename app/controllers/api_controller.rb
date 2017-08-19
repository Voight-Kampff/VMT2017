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

	def scan_order
		@order=Order.find(params[:id])
		if params[:code] == @order.code
			render json: 'valid'
			@reservations=@order.reservations.select{ |res| res.seat.concert.date.to_date == Date.today }
			@reservations.each do |res|
				res.update_column('scanned',true)
			end
		else
			render json: 'invalid code'
		end
	end

	def scan_seat_code
		@seat_code=SeatCode.find(params[:id])
		if params[:code] == @seat_code.code
			render json: 'valid'
			@seat=Seat.find(@seat_code.seat_id)
			unless @seat.reservation.nil?
				@seat.reservation.update_column('scanned',true)
			end
		else
			render json: 'invalid code'
		end
	end

end
