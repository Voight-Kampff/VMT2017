class InvitationsController < ApplicationController

  before_action :check_admin_authorization, except: [:show]

  def new
    @invitation=Invitation.new
    @concerts=Concert.all
    @reservation_types=ReservationType.all
  end

  def create

  	@order=Order.create(:held => '1')
  	@invitation= Invitation.create(invitation_params)
  	@invitation.order_id=@order.id

    if @invitation.save
    	redirect_to @invitation
      if @invitation.concert.nil?
        TicketMailer.member_invitation(@invitation).deliver
      else
        TicketMailer.specific_concert_invitation(@invitation).deliver
      end
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
      params.require(:invitation).permit(:email,:title,:first_name,:last_name,:road,:telephone,:town,:postcode,:country,:free_tickets,:reservation_type_id,:concert_id)
    end
    
end
