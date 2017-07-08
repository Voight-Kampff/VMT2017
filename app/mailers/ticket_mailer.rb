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

		open(@reservations.last.pdf_url) do |url_file|
  			tmp_file.write(url_file.read)
		end

		attachments[@reservations.last.pdf_name.to_s]= tmp_file.read

    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos billets pour les Variations Musicales de Tannay")
	end

	def ticket(order)
		@order = order
		@reservations=@order.reservations

		tmp_file = Tempfile.new
		tmp_file.binmode


		@reservations.each do |reservation|

			open(reservation.pdf_url.to_s) do |url_file|
	  			tmp_file.write(url_file.read)
			end

			tmp_file.rewind

			attachments["#{reservation.pdf_name}"]= tmp_file.read

		end
		
    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos billets pour les Variations Musicales de Tannay")
	end

end
