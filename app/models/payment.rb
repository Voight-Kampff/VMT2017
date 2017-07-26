class Payment
	def self.charge(order)
		Stripe.api_key = ENV['SECRET_KEY']
		customer = Stripe::Customer.create(
     	   :email => order.email,
      		:source  => order.stripe_token
      	)
        charge = Stripe::Charge.create({
            :customer => customer.id,
            :amount => order.calculate_price * 100,     # Amount is based in cents
            :currency => "chf",
            :description => order.id
        })	
    end
end