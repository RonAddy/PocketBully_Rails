# This controller will be used for reference by other controllers inheriting it's methods
# This controller is needed to make the auth methods private
class ApiController < ApplicationController
	
	def require_login
		authenticate_token || render_unauthorized("Access Denied")
	end
	
	# will be assigned user if nil, preventing mutliple calls to the database everytime user needs to be authorized
	def current_user
		@current_user ||= authenticate_token
	end
	
	protected
	
	def render_unauthorized(message)
		errors = { errors: [detail: message] }
		render json: errors, status:  :unauthorized 
	end
	
	private 
	
	# this method will find the user by the given token to make sure the current user is correct
	# authenticate_with_http_token comes from rails,
	# attaches genereated token to request for user 
	
	def authenticate_token 
		authenticate_with_http_token do | token, options| 
			User.find_by(auth_token: token)
		end
	end
	
end
