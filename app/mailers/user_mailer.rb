class UserMailer  < ApplicationMailer
	default from: "your_email@exapmle.com"
	def recovery(user)
		@user = user
		mail(to: @user.email, subject: "Forgot password")
	end

end
