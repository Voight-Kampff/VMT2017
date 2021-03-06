class TicketMailer < ApplicationMailer

	def member_invitation(invitation)

		@invitation=invitation

    	mail(:to => @invitation.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos invitations pour les Variations Musicales de Tannay")
	end

	def specific_concert_invitation(invitation)

		@invitation=invitation

    	mail(:to => @invitation.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos invitations pour les Variations Musicales de Tannay")
	end

	def ticket(order)
		@order = order
		@reservations=@order.reservations.joins(:seat => :concert).order("concerts.date")

		tmp_file = Tempfile.new
		tmp_file.binmode

		open(@order.pdf_url.to_s) do |url_file|
			tmp_file.write(url_file.read)
		end

		tmp_file.rewind

		attachments["#{@order.pdf_name}"]= tmp_file.read

		
    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Vos billets pour les Variations Musicales de Tannay")
	end

	def location_change(order)

		@order=order

		mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :subject => "Déplacement du concert de vendredi à Tannay")

	end

	def facture(order)
		@order = order
		@reservations=@order.reservations.joins(:seat => :concert).order("concerts.date")

		
    	mail(:to => @order.email, :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Votre commande pour les Variations Musicales de Tannay")
    end

    def ticketfacture(order)
		@order = order
		@reservations=@order.reservations.joins(:seat => :concert).order("concerts.date")

		tmp_file = Tempfile.new
		tmp_file.binmode

		open(@order.pdf_url.to_s) do |url_file|
			tmp_file.write(url_file.read)
		end

		tmp_file.rewind

		attachments["#{@order.pdf_name}"]= tmp_file.read

		
    	mail(:to => "claus.haessig@vtxnet.ch", :from => "Billetterie@musicales-tannay.ch", :bcc => "webmaster@musicales-tannay.ch", :subject => "Facture et billets pour les Variations Musicales de Tannay")
	end



end
