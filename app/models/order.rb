class Order < ApplicationRecord
	has_many :reservations
	has_many :seats, through: :reservations


    def calculate_price
      self.total=self.reservations.sum(:price)
    end

end
