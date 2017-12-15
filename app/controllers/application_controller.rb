class ApplicationController < ActionController::API
	# This will add tokens for us  (Since Rails 5 does not do this automatically)
	include ActionController::HttpAuthentication::Token::ControllerMethods

	def index
	end
	
end
