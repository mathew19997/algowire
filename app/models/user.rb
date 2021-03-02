class User < ApplicationRecord
	attr_accessor :password_confirmation
	validate :verify_password 

	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

	def verify_password
		errors.add(:password, "is not same") if self.password != self.password_confirmation
	end

	def self.verify_account(param)
		user = User.find_by(email: param[:email], password: param[:password])
		if user.nil?
			return false
		else
			return user
		end
	end

end
# self.changes["status"].present?