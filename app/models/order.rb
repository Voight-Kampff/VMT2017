class Order < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :seats, through: :reservations


    def pay_with_cc
      self.calculate_price
      self.generate_code
      self_payment_type="credit card payment"
      self.paid=1
    end

    def calculate_price
      self.total=self.reservations.sum(:price)
    end

    def generate_code
      self.code = SecureRandom.urlsafe_base64(20)

      require 'rqrcode'

      qrcode= RQRCode::QRCode.new(self.id.to_s+"-"+self.code.to_s)
      qr_png = qrcode.as_png(
        resize_gte_to: false,
          resize_exactly_to: true,
          fill: 'white',
          color: 'black',
          size: 260,
          border_modules: 0,
          module_px_size: 0,
          file: nil, # path to write
            )
      qr_png.save("/tmp/#{self.id.to_s}-#{self.code.to_s}.png", :interlace => true)
      
      # create a connection
      connection = Fog::Storage.new({
        :provider                 => 'AWS',
        :aws_access_key_id        => Rails.application.secrets.amazon_access_key_id,
        :aws_secret_access_key    => Rails.application.secrets.amazon_secret_access_key,
        :region                   => 'eu-west-1',
      })

      # First, a place to contain the glorious details
      
      bucket = connection.directories.get('variations')

      bucket.files.create(
      :key    => "#{self.id.to_s}-#{self.code.to_s}.png",
      :body   => File.open("/tmp/#{self.id.to_s}-#{self.code.to_s}.png"),
      :public => true
      )


    end

end
