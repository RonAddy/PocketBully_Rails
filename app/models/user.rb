# Model should handle the 'buisness' dealings with database
# any actions done to database should be done in model

class User < ApplicationRecord
	validates_uniqueness _of :username
	
	# first method given by bcrypt to handle password hashing
	# refer to monsters app for detailed look at sessions auth
	# has_secure_token being passed the column that should have token 
	has_secure_password
	has_secure_token :auth_token
	
	# this methid is called on the class itself to find the user in the table with given params
	# not for instances of user class!
	# authenticate method given by Bcrypt
	
	#makes use of bcrypt autnenticate mthod to match hashed password__digest with password attempt
	def self.validate_login(username, password)
		user = find_by(username: username)
		if user && user.authenticate(password)
			user
		end
	end
	
	#self is defined in the method to be used on the user instance that calls this method
	def invalidate_token
		self.update_columns(auth_token: nil)
	end
	
end
