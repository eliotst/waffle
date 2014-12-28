class SessionsController < ApplicationController
  protect_from_forgery except: :create

	def new
	end

	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			if user.is_valid
				log_in user
				redirect_back_or user
			else
				flash.now[:error] = "User email must be validated, please check your email."
				render "new"
			end
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
