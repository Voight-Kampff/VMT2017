class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	belongs_to :reservation_type

	before_update :update_price
	before_create :update_price

	private
		def update_price
			self.price = self.reservation_type.discount*self.seat.price/100
		end
end
