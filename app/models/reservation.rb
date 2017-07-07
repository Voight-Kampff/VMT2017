class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	belongs_to :reservation_type

	before_update :update_price
	before_create :update_price

	def generate_pdf_test
		@hypdf = HyPDF.htmltopdf(
			'<html><body><h1>#{self.id}</h1></body></html>',
			orientation: 'Portrait',
			copies: 1,
			test: true,
			bucket: 'variations',
			key: 'test-#{self.id}',
			# ... other options ...
			)
	end


	private
		def update_price
			self.price = self.reservation_type.discount*self.seat.price/100
		end
end
