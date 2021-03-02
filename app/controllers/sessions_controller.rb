class SessionsController < ApplicationController
	before_action :set_user, except: :destroy

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
		log_out(user) unless current_user
		redirect_to root_path
	end

	private

	def set_user
		@user = User.new
	end

	def session_params
		params.require(:user).permit(:email, :password)
	end
end
