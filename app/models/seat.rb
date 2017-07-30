class Seat < ApplicationRecord
	has_one :reservation
	belongs_to :concert
	has_one :order, through: :reservation
end
