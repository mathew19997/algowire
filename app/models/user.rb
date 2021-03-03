class User < ApplicationRecord
	attr_accessor :password_confirmation
	validate :verify_password , if: Proc.new { |user| user.password_confirmation.present? }
	validates :email, :password, presence: true
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

	def self.forgot_password(email)
		user = self.find_by(email: email)
		if !user.nil?
			user.recover_code = SecureRandom.hex()
			if user.save
				UserMailer.recovery(user).deliver_now
				return true
			end
		end
		return false
	end

end