class Invitation < ApplicationRecord
	belongs_to :order

	before_create :generate_slug

	private
		def generate_slug
			self.slug = self.slug=  SecureRandom.urlsafe_base64
		end

end
