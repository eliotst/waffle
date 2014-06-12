class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_auth_token!(params[:id])
  end

  def update
    @user = User.find_by_auth_token!(params[:id])
    if @user.password_reset_sent_at < 3.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password,
         :password_confirmation, :name, :address_line_one, 
         :address_line_two, :city, :state, :zip_code, 
         :auth_token, :password_reset_token )
    end

end