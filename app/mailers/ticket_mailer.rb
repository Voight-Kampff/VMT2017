class TicketMailer < ApplicationMailer


	def send_ticket(order)
		@order = order
		@reservations=@order.reservations

		qr= RQRCode::QRCode.new(@order.id.to_s+"-"+@order.code.to_s)
		@qr_png = qrcode.as_png(
			resize_gte_to: false,
	        resize_exactly_to: false,
	        fill: 'white',
	        color: 'black',
	        size: 260,
	        file: nil # path to write
          )

    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos billets pour les Variations Musicales de Tannay")
	end

	def ticket(order)
		@order = order
		@reservations=@order.reservations
		
    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos billets pour les Variations Musicales de Tannay")
	end

end
