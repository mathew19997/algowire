class SessionsController < ApplicationController
	before_action :set_user, except: :destroy
	before_action :user_logged_in, only: :new

	def create
		if user = User.verify_account(session_params)
			log_in(user)
			redirect_to sample_home_index_path
		else
			@errors = true
			render "new"
		end
	end

	def destroy
		log_out(current_user) if current_user
		redirect_to root_path
	end

	private

	def set_user
		@user = User.new
	end

	def user_logged_in
		redirect_to sample_home_index_path if current_user
	end

	def session_params
		params.require(:user).permit(:email, :password)
	end
end
