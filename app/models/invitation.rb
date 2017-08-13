class Invitation < ApplicationRecord
	belongs_to :order
	belongs_to :reservation_type, optional: true
	belongs_to :concert, optional: true

	before_create :generate_slug

	private
		def generate_slug
			self.slug = self.slug=  SecureRandom.urlsafe_base64
		end

end
