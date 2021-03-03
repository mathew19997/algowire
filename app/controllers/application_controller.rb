class ApplicationController < ActionController::Base

	def log_in(user)
		session[:user_id] = user.id
	end

	def log_out(user)
		session.delete(:user_id)
	end

	def current_user
		User.find_by(id: session[:user_id])
	end

	def authenticate_user
		if session[:user_id].nil? || current_user.nil?
			redirect_to new_session_path
		end
	end

end
