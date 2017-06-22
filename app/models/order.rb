class Order < ApplicationRecord
	has_many :reservations
	has_many :seats, through: :reservations

	def update_total
      reservations=self.reservations
      total=0
      reservations.each do |reservation|
        total=total+reservation.seat.price
      end
      return total
    end
end
