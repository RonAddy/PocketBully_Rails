class User < ApplicationRecord
	validates_uniqueness _of :username
	
	# method given by bcrypt to handle password hashing
	# refer to monsters app for detiled look at sessions auth
	has_secure_password
end
