class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	belongs_to :reservation_type

	before_update :update_price
	before_create :update_price

	def generate_pdf_test

		require 'web_to_pdf'
		
		# Note: the 'Controller' here is not a reference to Rails controllers
		# but an internal structure, won't interfere with your Rails app and will
		# work fine in a standalone ruby app or another framework

		wtp = WebToPdf::APIController.new
		data = wtp.lookup("https://news.ycombinator.com/", "10", "1024", "Wikipedia")

		# Writes the PDF file to the local directory
		File.open("news-yc.pdf","w"){|f| f.write(data)}
	end


	private
		def update_price
			self.price = self.reservation_type.discount*self.seat.price/100
		end
end
