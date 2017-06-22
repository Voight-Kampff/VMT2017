class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	
end
