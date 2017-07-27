class InvitationsController < ApplicationController

  before_action :check_authorization, except: [:show]

  def new
    @invitation=Invitation.new
  end

  def create

	@order=Order.create(:held => '1')

	@invitation= Invitation.create(invitation_params)

	@invitation.order_id=@order.id

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
