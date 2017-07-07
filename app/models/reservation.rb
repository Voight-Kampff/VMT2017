class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	belongs_to :reservation_type

	before_update :update_price
	before_create :update_price

	def generate_pdf
		@hypdf = HyPDF.htmltopdf(
			'<html><body><h1>Title</h1></body></html>',
			orientation: 'Portrait',
			copies: 1,
			# ... other options ...
			)

		# send PDF to user
		send_data(
		    @hypdf[:pdf],
		    filename: "pdf_with_#{@hypdf[:pages]}_pages.pdf",
		    type: 'application/pdf'
		)
	end


	private
		def update_price
			self.price = self.reservation_type.discount*self.seat.price/100
		end
end
