class Contact < ApplicationRecord

	has_and_belongs_to_many :tags, optional: true

	has_many :orders

end
