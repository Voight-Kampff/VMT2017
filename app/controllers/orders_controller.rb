class OrdersController < ApplicationController
  
  before_action :check_admin_authorization, only: [:hold]

  def new
  end

  def create
    if @order.save
      session[:order_id] = @order.id
    end
  end

  def edit
  end

  def hold
    @order = Order.find_by_id(params[:id])
    @order.place_hold(params[:hold_type])
    @order.reservations.map(&:save)
    @order.user = current_user
    @order.save

    if @order.save
      redirect_to '/concerts'
      session.delete(:order_id)
    else
    end

  end

  def success
    if Order.find_by_id(session[:order_id]).nil? ||  Order.find_by_id(session[:order_id]).paid != true
      redirect_to '/concerts'
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
      #session.delete(:order_id)
      @order.pay('credit card payment')
      @order.reservations.map(&:save)
      @order.reservations.map(&:generate_pdf)
      @order.save
      TicketMailer.ticket(@order).deliver
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
      params.require(:order).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country,:stripe_token,:hold_type)
    end

    def check_admin_authorization
      current_user.admin?
    end

end
