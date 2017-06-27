class Order < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :seats, through: :reservations


    def pay_with_cc
      self.calculate_price
      self.generate_code
      self_payment_type="Credit card payment"
      self.paid=1
    end

    def calculate_price
      self.total=self.reservations.sum(:price)
    end

    def generate_code
      self.code = SecureRandom.urlsafe_base64(20)
    end

end
