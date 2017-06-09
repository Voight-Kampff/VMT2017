class Order < ApplicationRecord
	has_many :reservations
	has_many :seats, through: :reservations
end
