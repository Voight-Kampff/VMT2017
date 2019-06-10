class Seat < ApplicationRecord
	has_one :reservation
	belongs_to :concert
	has_one :order, through: :reservation

	scope :free_seats, -> (concert) { includes(:reservation).where(reservations: {id: nil}, concert: concert)}
	scope :free_seats_coordinates, -> (concert) { Seat.free_seats(concert).pluck("row,column").map{|a| a.first.to_s+a.last.to_s}}

	scope :retrieve, -> (concert,row,column) { find_by(concert: concert, row: row, column: column)}

end
