class OrdersController < ApplicationController
  
  before_action :check_admin_authorization, only: [:hold]

  def new
  end

  def create
    if @order.save
      session[:order_id] = @order.id
    end
  end

  def show
    @order = Order.find_by_id(params[:id])
    @reservations = @order.reservations
    render layout: "ticket"
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

    retrieve_order

  end

  def invitationdelivery

    retrieve_order

    if @order.update(order_params)
      unless @order.invitation.nil?
        render 'success'
        @order.pay('invitations uniquement')
        @order.save
        GenerateTicketJob.perform_later(@order)
        session.delete(:order_id)
      else
        render 'paymentform'
      end
    else
      flash[:alert] = "Votre forumlaire contient #{@order.errors.count} #{"erreur".pluralize(@order.errors.count)}"
      render 'paymentform'
    end

  end

  def charge

    retrieve_order
    unless @order.processing == true || @order.paid == true
      @order.update_attribute(:processing, true)
      @order.update(order_params)
      charge = Payment.charge(@order)
      if @order.update(order_params)
        if charge.status=="succeeded"
          @order.pay('credit card payment')
          @order.save
          render 'success'
          GenerateTicketJob.perform_later(@order)
          session.delete(:order_id)
        else
          flash[:alert] = "Votre paiement n'a pas pu être validé. Merci de contacter #{mail_to('la billetterie','billetterie@musicales-tannay.ch')}"
          render 'paymentform'
        end
      else
        flash[:alert] = "Votre forumlaire contient #{@order.errors.count} #{"erreur".pluralize(@order.errors.count)}"
        render 'paymentform'
      end
      @order.update_column(:processing, false)
    else
      if @order.paid == true
        render 'success'
        session.delete(:order_id)
      end
    end

  end

  def update
    retrieve_order
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

end
