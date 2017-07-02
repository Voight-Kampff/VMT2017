class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	belongs_to :reservation_type
end
