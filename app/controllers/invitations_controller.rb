class InvitationsController < ApplicationController
  def new
  	@invitation=Invitation.new
  end

  def create

  	if Order.find_by_id(session[:order_id]).nil?
		@order=Order.create
		session[:order_id] = @order.id
	else
		@order = Order.find_by_id(session[:order_id])
	end

	@invitation= Invitation.new

	@invitation.order_id=@order.id

  	@order.create_invitation(invitation_params)

  	if @invitation.save
  		redirect_to @invitation
  	else
  		render 'invitations/new'
  	end
  end

  def show

  	@invitation=Invitation.find_by_slug(params[:slug])

  	@order=@invitation.order
  	session[:order_id] = @order.id

  end

  private
    
    def invitation_params
      params.require(:invitation).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country,:free_tickets)
    end


end
