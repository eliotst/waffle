class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

	def new
		@user = User.new
	end
  
 	def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Signed up! Thank you!"
   		redirect_to @user
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
    redirect_to root_url
  end

	private
		def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
		end

end
