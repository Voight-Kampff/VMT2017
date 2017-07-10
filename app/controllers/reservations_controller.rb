class ReservationsController < ApplicationController

	def new
		@concert=Concert.find_by_id(params[:concert_id])

		if Order.find_by_id(session[:order_id]).nil?
			@order=Order.new
		else
			@order = Order.find_by_id(session[:order_id])
		end

		unless @concert.unnumbered?

			@rows=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S"]

			@reservation = Reservation.new
			@reservation.order_id=@order.id

			@seats= @concert.seats
			@taken_seat_array=Array.new

			0..475.times do |i|
				if @seats[i].reservation.present?
					@taken_seat_array[i]=1
					if @seats[i].reservation.order_id == @order.id
						@taken_seat_array[i]=2
					end
				end
			end
		end
	end

	def create
		

		if Order.find_by_id(session[:order_id]).nil?
			@order=Order.create
			session[:order_id] = @order.id
		else
			@order = Order.find_by_id(session[:order_id])
		end
		
		@reservation = Reservation.create(reservation_params)
		
		@reservation.order_id=@order.id
		@reservation.reservation_type_id=1
		@reservation.price=@reservation.seat.price

		if @reservation.save
			respond_to do |format|
				format.html { render nothing: true } 
				format.js { } 
			end
			
    	end	

    	@order.total=@order.calculate_price

	end

	def unnumbered

		if Order.find_by_id(session[:order_id]).nil?
			@order=Order.create
			session[:order_id] = @order.id
		else
			@order = Order.find_by_id(session[:order_id])
		end

		@concert=Concert.find_by_id(params[:id])

		selection_count = params[:selection_count].to_i

		difference = (selection_count-@order.reservations.select{ |reservation| reservation.seat.concert == @concert }.count)

		if difference > 0

			@selected_seats=@concert.seats.select{ |seat| seat.reservation == nil }.first(difference)

			difference.to_i.times do |index|

				reservation=Reservation.new
				reservation.order_id=@order.id
				reservation.seat_id=@selected_seats[index].id
				reservation.reservation_type_id=1
				reservation.save

			end
		
		elsif difference < 0

			@current_concert_reservations=@order.reservations.select{ |reservation| reservation.seat.concert == @concert }

			difference.abs.times do |reservation|
				@current_concert_reservations[reservation].delete
			end
		else
			#ensure no strange behaviour
		end

		redirect_to reservations_basket_path

	end

	def show
		@reservation=Reservation.find_by_id(params[:id])
		render layout: "ticket"
	end

	def edit
	end

	def update
		@reservation=Reservation.find_by_id(params[:id])
		@reservation.update(reservation_params)
	end

	def basket
    	@order = Order.find_by_id(session[:order_id])
    	@reservations=@order.reservations
 	end

	def destroy
		Seat.find(params[:reservation][:seat_id]).reservation.destroy
		respond_to do |format|
			format.html { render nothing: true } 
			format.js { render nothing: true } 
    	end
	end

	def delete
		Reservation.find(params[:id]).delete
		respond_to do |format|
			format.html { render nothing: true } 
			format.js { render nothing: true } 
    	end
	end

	def delete_by_seat_id
		respond_to do |format|
			format.html { render nothing: true } 
			format.js { render nothing: true } 
    	end
	end

	private
		
		def reservation_params
			params.require(:reservation).permit(:seat_id,:reservation_type_id)
		end

end
