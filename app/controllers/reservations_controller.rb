class ReservationsController < ApplicationController

	def new
		@concert=Concert.find_by_id(params[:concert_id])

		if Order.find_by_id(session[:order_id]).nil?
			if user_signed_in?
				@order=Order.create(user_id: current_user.id)
			else
				@order=Order.create
			end
			session[:order_id] = @order.id
		else
			@order = Order.find_by_id(session[:order_id])
		end

		unless @concert.unnumbered?

			@rows=["A","B","C","D","E","F","G","H","I","J","L","M","N","O","P","Q","R","S","T"]

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

		@free_seats=Seat.free_seats_coordinates(@concert)

		

		respond_to do |format|
				format.js {render layout: false} 
				format.html
		end

	end

	def create
		

		if Order.find_by_id(session[:order_id]).nil?
			if user_signed_in?
				@order=Order.create(user_id: current_user.id)
			else
				@order=Order.create
			end
			session[:order_id] = @order.id
		else
			@order = Order.find_by_id(session[:order_id])
		end
		
		#note sure the merge for type id = 1 is necessary
		@reservation = Reservation.create(reservation_params.merge(order_id: @order.id).merge(reservation_type_id: '1'))
		@reservation.assign_reservation_type
		
		if @reservation.save
			ActionCable.server.broadcast 'reservations',
				seat: @reservation.seat_id
			respond_to do |format|
				format.html { render nothing: true } 
				format.js { render 'create.js.erb' }
			end	
		else
		end

    	@order.total=@order.calculate_price

	end

	def unnumbered

		if Order.find_by_id(session[:order_id]).nil?
			if user_signed_in?
				@order=Order.create(user_id: current_user.id)
			else
				@order=Order.create
			end
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
				reservation.assign_reservation_type
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

		respond_to do |format|
			format.html {redirect_to reservations_basket_path}
			format.js 
		end

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

		respond_to do |format|
			if @reservation.update(reservation_params)
				format.js 
			else
				format.js { render 'test.js.erb' }
			end
		end
	end

	def basket
		if Order.find_by_id(session[:order_id]).nil?
			redirect_to '/concerts'
		else
	    	@order = Order.find_by_id(session[:order_id])
	    	@reservations = @order.reservations.joins(:seat => :concert).order("concerts.date")
	    end
 	end

	def destroy
		@order = Order.find_by_id(session[:order_id])
		Reservation.find(params[:id]).destroy
		respond_to do |format|
			format.html { render nothing: true } 
			format.js
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
		@reservation=Seat.find(params[:reservation][:seat_id]).reservation
		@reservation.destroy
		if @reservation.destroy
				ActionCable.server.broadcast 'reservations',
				seat: @reservation.seat_id
			respond_to do |format|
				format.html { render nothing: true } 
				format.js { render nothing: true } 
	    	end
    	end
	end

	private
		
		def reservation_params
			params.require(:reservation).permit(:seat_id,:reservation_type_id)
		end

end
