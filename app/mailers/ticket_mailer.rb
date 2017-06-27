class TicketMailer < ApplicationMailer

	require 'rqrcode'

	def send_ticket(order)
		@order = order
		@reservations=@order.reservations

		@qr= RQRCode::QRCode.new(@order.id.to_s+"-"+@order.code.to_s)
		
    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos billets pour les Variations Musicales de Tannay")
	end
end
