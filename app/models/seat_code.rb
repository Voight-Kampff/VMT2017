class SeatCode < ApplicationRecord
	belongs_to :seat, optional: true

	before_save :assign_params

	def assign_params
		
		unless self.seat.nil?
			self.row = self.seat.row
			self.column = self.seat.column
			self.concert_name = self.seat.concert.name
			self.concert_date = (I18n.localize self.seat.concert.date, format: :concert).capitalize
		end

		if self.code.nil?
			self.code = SecureRandom.urlsafe_base64(20)
		end

	end

end
