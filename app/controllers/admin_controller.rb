class AdminController < ApplicationController

	#includes the secured concern (module) for auth0
	include Secured


	#acts as a root page of sorts for the admin section. Currently a test page
	def dashboard
		
	end

end