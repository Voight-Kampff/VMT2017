class Scan < ApplicationRecord
	belongs_to :reservation

	def check(code)
		self.check_existence
		self.check_for_duplicates unless self.status == false
		self.check_date unless self.status == false
		self.check_code(code) unless self.status == false
		self.check_type unless self.status == false
	end



	def check_existence
		if Reservation.where(id: self.reservation_id).exists?
			@reservations=Reservation.find(self.reservation_id)
		else
			self.status = false
			self.message="Réservation Introuvable"
		end
	end

	def check_for_duplicates
		if self.reservation.scans.where(status: true).count > 0
			self.status = false
			self.message= "Réservation déjà scannée"
		end
	end

	def check_date
		if self.reservation.seat.concert.date.to_date != Date.today
			self.status = false
			self.message = "Mauvaise date!"
		end
	end

	def check_code(code)
		if code == self.reservation.code
			self.status = true
			self.message = "OK"
		else
			self.status = false
			self.message = "Mauvais code!"
		end
	end

	def check_type
		if self.reservation.reservation_type_id == 2
			self.message = "Est-ce que c'est un enfant?"
		end

		if self.reservation.reservation_type_id == 3
			self.message = "Est-ce que c'est un étudiant?"
		end
	end

end
