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

    if @order.update(order_params)
      unless @order.invitation.nil?
        render 'success'
        @order.pay('invitations uniquement')
        #@order.reservations.map{ |r| r.update_column('code',r.code) }
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

    if Order.find_by_id(session[:order_id]).nil?
      redirect_to 'concerts#index'
    else
      @order = Order.find_by_id(session[:order_id])
    end

    @order.update(order_params)

    charge = Payment.charge(@order)

    if @order.update(order_params)
      if charge.status=="succeeded"
        render 'success'
        @order.pay('credit card payment')
        #ShouldRemove and have autosave instead
        #@order.reservations.map(&:save)
        @order.save
        GenerateTicketJob.perform_later(@order)
        session.delete(:order_id)
      else
        flash[:alert] = "Votre paiement n'est pas pu être validé. Merci de contacter #{mail_to('la billetterie','billetterie@musicales-tannay.ch')}"
        render 'paymentform'
      end
    else
      flash[:alert] = "Votre forumlaire contient #{@order.errors.count} #{"erreur".pluralize(@order.errors.count)}"
      render 'paymentform'
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
      if user_signed_in?
        current_user.admin?
      end
    end

end
