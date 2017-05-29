class Concert < ApplicationRecord
	has_many :seats
	has_many :reservations, through: :seats
end
