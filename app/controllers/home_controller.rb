class HomeController < ApplicationController
	before_action :authenticate_user, only: [:sample]
	before_action :set_user

	def sample
		#sample 
	end

	private

	def set_user
		@user = current_user
	end
end
