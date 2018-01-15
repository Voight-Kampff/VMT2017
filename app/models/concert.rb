class Concert < ApplicationRecord
	has_many :seats
	has_many :reservations, through: :seats
	belongs_to :location
	has_and_belongs_to_many :reservation_types, optional: true

	mount_uploader :image, ImageUploader

	attr_accessor :cat_A_price
	attr_accessor :cat_B_price
	attr_accessor :number_of_seats
	attr_accessor :single_price

	def free_seats_count
		self.seats.count-self.reservations.count
	end

	def full?
		self.seats.count == 0
	end

end
