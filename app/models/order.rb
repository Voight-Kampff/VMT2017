class Order < ApplicationRecord
	
  has_many :reservations, dependent: :destroy, autosave: true
	has_many :seats, through: :reservations
  has_one :invitation
  belongs_to :user, optional: true

  before_save :calculate_price
  before_update :calculate_price

  validates :first_name, :last_name, :email, :title, :road, :postcode, :town, :country, presence: true, on: :update, unless: :user_created?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, on: :update, unless: :user_created?


    def pay(method)
      self.update_column('paid',true)
      self.calculate_price
      self.payment_type=method.to_s
      self.held=0
      self.paid=1
      unless self.invitation.nil?
        self.invitation.used = 1
        self.invitation.save
      end
      self.reservations.map(&:generate_code)
    end

    def calculate_price
      self.total=self.reservations.sum(:price)
    end

    def code_url
      "https://s3-eu-west-1.amazonaws.com/variations/#{self.id.to_s}-#{self.code.to_s}.png"
    end

    def place_hold(type)
      unless ReservationType.find_by_name(type).nil?
        reservation_type=ReservationType.find_by_name(type)
        self.reservations.each do |reservation|
          reservation.reservation_type=reservation_type
        end
      end
      self.paid=0
      self.held=1
      self.hold_type=type
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

    def generate_pdf

      $docraptor = DocRaptor::DocApi.new

      response = $docraptor.create_doc(
        test:             false,                                         # test documents are free but watermarked
            # supply content directly
        document_url:   "http://musicales-tannay.herokuapp.com/orders/#{self.id}", # or use a url
        name:             self.pdf_name,                         # help you find a document later
        document_type:    "pdf",                                        # pdf or xls or xlsx
        javascript:       true,                                       # enable JavaScript processing
        prince_options: {
            media: "screen",                                            # use screen styles instead of print styles
        #   baseurl: "http://hello.com",                                # pretend URL when using document_content
        },
      )

      File.open("/tmp/#{self.pdf_name}", "wb") do |file|
          file.write(response)
        end

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
        :key    => self.pdf_name,
        :body   => File.open("/tmp/#{self.pdf_name}"),
        :public => true
        )

    end

    def invitations_only?
      unless self.invitation.nil?
        if self.reservations.where(reservation_type: ReservationType.where(:name => [self.invitation.reservation_type.name.to_s,"Enfant"])).count == self.reservations.count
          return true
        else
          return false
        end
      end
    end

    def options_for_hold(current_user=nil)
      if (current_user.nil? == false) && (current_user.admin? == true)
        options=['Ticketcorner','En attente de paiement', 'Réserve']
      else
      end
        return options
    end

    def pdf_name
      (I18n.localize self.updated_at, format: "%Y-%m-%d").to_s+"-"+self.id.to_s+"-"+URI.escape(self.last_name)+".pdf"
    end

    def pdf_url
      "https://s3-eu-west-1.amazonaws.com/variations/"+self.pdf_name
    end

    def user_created?
      self.user_id.present?
    end

end
