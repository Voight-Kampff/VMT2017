class ReservationType < ApplicationRecord
	has_many :reservations
	has_many :invitations
	has_and_belongs_to_many :concerts, optional: true
end
