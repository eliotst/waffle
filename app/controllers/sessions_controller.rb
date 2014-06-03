class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			log_in user
			redirect_back_or user
		else
			flash.now[:error] = "Invalid email or password"
			render "new"
		end
	end

	def destroy
		log_out
		redirect_to root_url, :notice => "Logged out!"
	end
end