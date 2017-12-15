# This controller will also inherit from the ApiController
class UsersController < ApiController
	before_action :require_login, except: [:create, :index]

	# create without ! will return boolean
	# create with ! will return user or error
	def home
		
	end

	def create
		user = User.create!(user_params)
		render json:{token: user.auth_token}
	end

	def profile
		user = User.find_by_auth_token!(request.headers[:token])
		render json: {user: { username: user.username, email: user.email, fname: user.fname, lname: user.lname}}
	end

	private
	#used to limit accessible columns from user object
	def user_params
		params.require(:user).permit(:username, :password, :email, :fname, :lname)
	end

end
