class Concert < ApplicationRecord
	has_many :seats
	has_many :reservations, through: :seats

	attr_accessor :cat_A_price
	attr_accessor :cat_B_price

end
