class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action [:correct_user, :admin_user],   only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @participant = @user.create_participant
    if @user.save
      flash[:success] = "Signed up! Thank you! 
        You should receive a validation email shortly."
      @user.send_validation
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "Profile updated!"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    if current_user.admin?
      redirect_to users_url
    else
      redirect_to root_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password,
         :password_confirmation, :name, :address_line_one, 
         :address_line_two, :city, :state, :zip_code, 
         :auth_token, :password_reset_token )
    end

    #Before filters

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to log_in_url, notice: "Please log in."
      end  
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end