class OrdersController < ApplicationController
  def new
  end

  def create
    if @order.save
      session[:order_id] = @order.id
    end
  end

  def edit
  end

  def update
    @order = Order.find_by_id(session[:order_id])
    if params[:commit] == 'Payment par carte'
      @order.pay('credit card payment')
    elsif params[:commit] == 'Virement bancaire'
      @order.pay('bank transfer')
    end
    @order.save(order_params)
    @order.reservations.map(&:save)
    @order.reservations.map(&:generate_pdf)
    if @order.save
      TicketMailer.ticket(@order).deliver
    else
    end
  end

  def delete
  end

  def destroy
  end

  private
    
    def order_params
      params.require(:order).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country)
    end

end
