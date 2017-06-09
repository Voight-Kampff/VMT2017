class Seat < ApplicationRecord
	has_one :reservation
	belongs_to :concert
end
