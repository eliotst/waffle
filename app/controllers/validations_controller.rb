class ValidationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_validation if user
    redirect_to root_url, :notice => "Email validation sent!"
  end

  def edit
    @user = User.find_by_valid_token!(params[:id])
    if @user
      @user.is_valid = true
      @user.save!(validate: false)
      redirect_to root_url, :notice => "Email validated!"
    else
      redirect_to root_url, :notice => "Invalid user or link."
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password,
         :password_confirmation, :name, :address_line_one, 
         :address_line_two, :city, :state, :zip_code, 
         :auth_token, :password_reset_token, :valid_token, :is_valid )
    end

end