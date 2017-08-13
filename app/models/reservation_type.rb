class ReservationType < ApplicationRecord
	has_many :reservations
	has_many :invitations
end
