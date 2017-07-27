class TicketMailer < ApplicationMailer

	def invitation(invitation)

		@invitation=invitation

    	mail(:to => @invitation.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos invitations pour les Variations Musicales de Tannay")
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
