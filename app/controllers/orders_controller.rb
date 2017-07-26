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

  def success
    if Order.find_by_id(session[:order_id]).nil? ||  Order.find_by_id(session[:order_id]).paid != true
      redirect_to 'concerts#index'
    else
      @order = Order.find_by_id(session[:order_id])
      session.delete(:order_id)
    end
  end

  def paymentform

    if Order.find_by_id(session[:order_id]).nil?
      redirect_to 'concerts#index'
    else
      @order = Order.find_by_id(session[:order_id])
    end

  end

  def invitationdelivery

    if Order.find_by_id(session[:order_id]).nil?
      redirect_to 'concerts#index'
    else
      @order = Order.find_by_id(session[:order_id])
    end

    @order.update(order_params)

    unless @order.invitation.nil?
      redirect_to '/merci'
      @order.pay('invitations uniquement')
      @order.reservations.map(&:save)
      @order.reservations.map(&:generate_pdf)
      @order.save
      TicketMailer.send_ticket(@order).deliver
    else
      redirect_to '/paiement'
    end
  end


  def charge

    if Order.find_by_id(session[:order_id]).nil?
      redirect_to 'concerts#index'
    else
      @order = Order.find_by_id(session[:order_id])
    end

    @order.update(order_params)

    charge = Payment.charge(@order)

    if charge.status=="succeeded"
      redirect_to '/merci'
      session.delete(:order_id)
      @order.pay('credit card payment')
      @order.reservations.map(&:save)
      @order.reservations.map(&:generate_pdf)
      @order.save
      TicketMailer.send_ticket(@order).deliver
    else
      redirect_to '/paiement'
    end

  end


  def update
    @order = Order.find_by_id(session[:order_id])
    @order.update(order_params)
  end

  def delete
  end

  def destroy
  end

  private
    
    def order_params
      params.require(:order).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country,:stripe_token)
    end

end
