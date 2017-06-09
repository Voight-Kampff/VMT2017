class OrdersController < ApplicationController
  def new
  end

  def create
    if @order.save
      session[:order_id] = @order.id
      #redirect_to new_concert_reservation_path(params[:concert_id])
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end
end
