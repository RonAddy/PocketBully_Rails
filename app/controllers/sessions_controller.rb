# this class will inherit from ApiController to have access to methods
class SessionsController < ApiController
	# will skip check for user to be logged in.
	# only for when users are signing in/registering (create view)
	skip_before_action :require_login, only: [:create], raise: false
	
	# will create a new session for user if they are validated 
	def create
		if user = User.validate_login(params[:username], params[:password])
			allow_token_to_be_used_only_once_for(user)
			send_token_for_valid_login_of(user)
		else
			render_unauthorized("Error with your login or password")
		end
	end
	
	def destroy
		logout
		head :ok		
	end
	
	# private methods can only be accessed within this class.
	# Instances of the class cannot have access to these. 
	# Also will throw error if called with 'self'
	
	private
	
	#will give user a new token
	def allow_token_to_be_used_only_once_for(user)
		user.regenerate_auth_token
	end
	
	# will send back token that was generated
	def send_token_for_valid_login_of(user)
		render json: {token: user.auth_token }
	end
	
	def logout
		current_user.invalidate_token
	end
end
