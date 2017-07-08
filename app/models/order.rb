class Order < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :seats, through: :reservations

    def pay_with_cc
      self.calculate_price
      self.payment_type="credit card payment"
      self.paid=1
      self.reservations.map(&:issue_ticket)
    end

    def calculate_price
      self.total=self.reservations.sum(:price)
    end

    def code_url
      "https://s3-eu-west-1.amazonaws.com/variations/#{self.id.to_s}-#{self.code.to_s}.png"
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
        :aws_access_key_id        => ENV['AWS_ACCESS_KEY'],
        :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY'],
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
