class Reservation < ApplicationRecord
	belongs_to :order
	belongs_to :seat
	belongs_to :reservation_type

	before_update :update_price
	before_create :update_price

	def code_url
      "http://s3-eu-west-1.amazonaws.com/variations/r-#{self.id.to_s}-#{self.code.to_s}.png"
    end

    def pdf_name
    	(I18n.localize self.seat.concert.date, format: "%Y-%m-%d").to_s+"-"+self.seat.row.to_s+self.seat.column.to_s+".pdf"
    end

    def pdf_url
    	"https://s3-eu-west-1.amazonaws.com/variations/"+self.pdf_name
    end

	def generate_pdf

		$docraptor = DocRaptor::DocApi.new

		response = $docraptor.create_doc(
		  test:             false,                                         # test documents are free but watermarked
		      # supply content directly
		  document_url:   "http://vmt-tickets2.herokuapp.com/reservations/#{self.id}", # or use a url
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

	def generate_code

		if self.code.nil?

    	self.code = SecureRandom.urlsafe_base64(20)

    	require 'rqrcode'

    	qrcode= RQRCode::QRCode.new("r-"+self.id.to_s+"-"+self.code.to_s)
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
		qr_png.save("/tmp/r-#{self.id.to_s}-#{self.code.to_s}.png", :interlace => true)
      
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
			:key    => "r-#{self.id.to_s}-#{self.code.to_s}.png",
			:body   => File.open("/tmp/r-#{self.id.to_s}-#{self.code.to_s}.png"),
			:public => true
		)

		end

	end


	private
		def update_price
			self.price = self.reservation_type.discount*self.seat.price/100
		end
end
