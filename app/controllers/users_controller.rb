class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
  end

	def new
		@user = User.new
	end
  
 	def create
  	@user = User.new(user_params)
  	if @user.save
   		redirect_to root_url, :notice => "Signed up!"
  	else
   		render "new"
  	end
	end

  def edit
    @user = User.update_attributes(user_params)
  end

  def update
  end

  def destroy
  end

	private
		def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
		end

end
