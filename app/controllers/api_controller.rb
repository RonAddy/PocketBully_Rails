class ApiController < ApplicationController
	def require_login
		authenticate_token || render_unauthorized("Access Denied")
end
